class CallsController < ApplicationController
  before_action :set_call, only: [:show, :edit, :update, :destroy, :takecall, :markdone]
  before_action :checkadmin, except: [:new, :create, :show, :index, :takecall, :overview]
  before_action :checkadminuser, only: [:index, :overview]
  skip_before_action :authenticate_user!, only: [:new, :create]

  # GET /calls
  # GET /calls.json
  def index
    @calls = Call.all.order(created_at: :desc).page(params[:page])
    @call = Call.new
    @region = Region.new
    @user_show = ""
    return if params["call"].nil? # breaks if no filter input

    filter_search
  end

  # GET /calls/1
  # GET /calls/1.json
  def show
    if @call.user.nil?
      @taken = false
    elsif @call.user == current_user || current_user.issuper?
      @taken = true
    else
      redirect_to :root, notice: CALL_ERROR
    end
  end

  def overview
    @caller = Call.new
    @calls = Call.where(admindone: false, done: true)
    if !params["call"].nil?
      if !params["call"]["donetime"].empty?
        if !params["call"]["created_at"].empty?
          date1 = Date.strptime(params[:call][:donetime], '%m/%d/%Y')
          date2 = Date.strptime(params[:call][:created_at], '%m/%d/%Y')
          date1 > date2 ? @calls = @calls.where(donetime: date2..date1) : @calls = @calls.where(donetime: date1..date2)
          @caller.donetime = params[:call][:donetime]
          @caller.created_at = params[:call][:created_at]
        else
        @calls = @calls.where(donetime: Date.strptime(params[:call][:donetime], '%m/%d/%Y'))
        @caller.donetime = params[:call][:donetime]
        end
      end
      if !params["call"]["city_id"].empty?
        @calls = @calls.where(city: params["call"]["city_id"])
        @caller.city_id = params["call"]["city_id"].to_i
      end
    end
  end

  def markdone
    if @call.user == current_user || !current_user.isvol?
      @call.update(done: true)
      redirect_to :root, notice: CALL_MARKED
    else
      redirect_to :root, notice: CALL_UNAUTH
    end
  end

  def adminmarkdone # POST REQUEST
    calls = params["call"]
    safecalls = []
    if calls.empty?
      redirect_to :root, notice: ERROR_500
    else
      calls.each { |call| safecalls << call[0].to_i if /\A\d+\z/.match(call[0]) && call[1] == "1" }
      Call.where(id: safecalls).update(admindone: true)
      redirect_to :root, notice: CALL_MARKED
    end
  end

  def takecall
    if params[:take] == "true"
      if @call.user == current_user
        @call.update(user: nil, healthcheck: false)
        redirect_to :root, notice: CALL_UNTAKEN
      else
        redirect_to :root, notice: CALL_UNAUTH
      end
    else
      @call.update(user: current_user, healthcheck: true)
      redirect_to showcall_path(@call.id), notice: CALL_TAKEN
    end
  end

  # GET /calls/new
  def new
    @call = Call.new
  end

  # GET /calls/1/edit
  def edit
  end

  # POST /calls
  # POST /calls.json
  def create
    @call = Call.new(call_params)
    respond_to do |format|
      if @call.save
        format.html { redirect_to "https://solidarity.org.il/%d7%a4%d7%a0%d7%99%d7%99%d7%aa%d7%9a-%d7%94%d7%aa%d7%a7%d7%91%d7%9c%d7%94/" }
      else
        format.html { render :new }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calls/1
  # PATCH/PUT /calls/1.json
  def update
    respond_to do |format|
      if @call.update(call_params)
        format.html { redirect_to @call, notice: CALL_UPDATED }
        format.json { render :show, status: :ok, location: @call }
      else
        format.html { render :edit }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1
  # DELETE /calls/1.json
  def destroy
    @call.destroy
    respond_to do |format|
      format.html { redirect_to calls_url, notice: CALL_DESTROYED }
      format.json { head :no_content }
    end
  end

  private

  def filter_search
    # SET FORM
    city_id = params["call"]["city_id"]
    user = params["call"]["user"]
    region_id = params["call"]["region"]["name"]
    call_done = params["call"]["done"]
    @call.city_id = city_id
    @user_show = user == "true" if user != ""
    @call_done = call_done == "true" if call_done != ""
    @region.id = region_id.to_i
    # SEARCH
    if @user_show == false # filter on (SEARCH RESULT = NO USERS)
      @calls = Call.where(user: nil)
    elsif @user_show == true # filter on (SEARCH RESULT = USERS)
      @calls = Call.where.not(user: nil)
    end
    if @region.id.zero? # region not selected
      @calls = @calls.where(city: @call.city) unless @call.city_id.nil? # default no filter
    else
      if @user_show == false # filter on (SEARCH RESULT = NO USERS)
        @calls = Region.find(@region.id).call.where(user: nil)
      elsif @user_show == true # filter on (SEARCH RESULT = USERS)
        @calls = Region.find(@region.id).call.where.not(user: nil)
      else
        @calls = Region.find(@region.id).call
      end
    end
    @calls = @calls.where(done: call_done) unless call_done.nil? || call_done.empty?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_call
    @call = Call.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def call_params
    params.require(:call).permit(:user_id, :name, :lastname, :phone, :address, :city_id, :email, :description, :healthcheck, :done, availability: [], help_option_ids: [])
  end
end
