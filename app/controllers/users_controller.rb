class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :checkadminuser
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @user = User.new
    @region = Region.new
    @help_choice = ""
    return if params["user"].nil? # breaks if no filter input

    filter_search
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "משתמש #{CREATE_MSG}" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    return if verify_user(user_params)

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "משתמש #{UPDATE_MSG}" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "משתמש #{DESTROY_MSG}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def filter_search
      # SET FORM
      city_id = params["user"]["city_id"]
      @user_name = params["user"]["name"]
      region_id = params["user"]["region"]["name"]
      help_opts = params["user"]["help_option_ids"]
      help_opts = help_opts.reject(&:empty?).map(&:to_i)
      @help_choice = help_opts
      @user_cities = city_id.reject(&:empty?).map(&:to_i)
      # @user = help_opts == "true" if user != ""
      @region_ids = region_id.reject(&:empty?).map(&:to_i)
      if @region_ids.empty? && !@user_cities.empty? # region not selected
        @users = User.where(city_id: city_id)
      elsif !@region_ids.empty?
        @users = User.joins(:city).where(cities: { region_id: region_id })
      end
      @users = @users.joins(:user_options).where(user_options: { help_option_id: help_opts }) unless help_opts.empty?
      @users = @users.where(name: @user_name) unless @user_name.empty?
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:helpcalls, :helpoperations, :solidaritylocaladdress, :joinlocal, :lastcontact, :contactname, :keepvolunteer, :pastvolunteervolume, :pastvolunteer, :volunteerusefull, :workfield, :specality, :helplocal, :solidaritycampus, :campus, :campusactivity, :studentactivist, :intrestedinsolidarity, :localwhatsapp, :othermentions, :email, :lastname, :name, :gender, :phone, :address, :student, :city_id, :adminlevel, :israelid, :healthcheck, availability: [], langauges: [], help_option_ids: [])
      # if current_user.iscaller? # cool way to check if caller may revert in the future
        # [:adminlevel, :name, :lastname, :email].each { |i| render_error if params[:user].include?(i) } # may revert to this in the future
      # end
    end

    def verify_user(user_params)
      # binding.pry
      return if @current_user.isadmin? # ALL ALLOWED

      if @current_user.issuper? # ALL ALLOWED EXECPT changing admin level above caller
        render_error if user_params["adminlevel"].to_i > 1
      elsif @current_user.iscaller?
       # render_error unless user_params["adminlevel"].to_i == @user.adminlevel && user_params["email"] == @user.email && user_params["name"] == @user.name && @user.lastname == user_params["name"]
        # render_error unless user_params["adminlevel"].to_i == @user.adminlevel && user_params["email"] == @user.email && user_params["name"] == @user.name && @user.lastname == user_params["name"]
      end
    end

    def render_error
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity, notice: CALL_INSUFFICIENT }
      end
    end
end
