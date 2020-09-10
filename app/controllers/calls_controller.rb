class CallsController < ApplicationController
  before_action :set_call, only: [:show, :edit, :update, :destroy]
  before_action :checkadmin, except: [:new, :create, :show]
  skip_before_action :authenticate_user!, only: [:new, :create]

  # GET /calls
  # GET /calls.json
  def index
    @calls = Call.all
  end

  # GET /calls/1
  # GET /calls/1.json
  def show
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
        format.html { redirect_to "https://solidarity.org.il/%d7%a4%d7%a0%d7%99%d7%99%d7%aa%d7%9a-%d7%94%d7%aa%d7%a7%d7%91%d7%9c%d7%94/", notice: 'Call was successfully created.' }
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
        format.html { redirect_to @call, notice: 'Call was successfully updated.' }
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
      format.html { redirect_to calls_url, notice: 'Call was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call
        @call = Call.find(params[:id])
    end

    def checkadmin
      if current_user.adminlevel < 10
        redirect_to :root, notice: "Insufficient rights!"
      end
    end

    # Only allow a list of trusted parameters through.
    def call_params
      params.require(:call).permit(:name, :lastname, :phone, :address, :city_id, :email, :description, :healthcheck)
    end
end
