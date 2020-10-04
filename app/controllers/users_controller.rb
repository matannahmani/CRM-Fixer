class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :checkadmin
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
      region_id = params["user"]["region"]["name"]
      help_opts = params["user"]["help_option_ids"]
      help_opts = help_opts.reject(&:empty?).map(&:to_i)
      @help_choice = help_opts
      @user_cities = city_id.reject(&:empty?).map(&:to_i)
      # @user = help_opts == "true" if user != ""
      @region_ids = region_id.reject(&:empty?).map(&:to_i)
      # binding.pry
      # SEARCH
      if @region_ids.empty? && !@user_cities.empty? # region not selected
        @users = User.where(city_id: city_id)
      elsif !@region_ids.empty?
        @users = User.joins(:city).where(cities: { region_id: region_id })
      end
      @users = @users.joins(:user_option).where(user_options: { help_option_id: help_opts }) unless help_opts.empty?
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :lastname, :name, :gender, :phone, :address, :student, :city_id, :adminlevel, :israelid, :healthcheck, :help_option_ids=> [])
    end
end
