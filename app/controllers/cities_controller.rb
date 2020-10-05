class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  before_action :checkadmin
  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all
    @city = City.new
    return if params["city"].nil? # breaks if no filter input

    filter_search
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: "העיר #{CREATE_MSG}" }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: "העיר #{UPDATE_MSG}" }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: "העיר #{DESTORY_MSG}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def filter_search
      @cities_name = params["city"]["name"].reject(&:empty?).map(&:to_i)
      @regions_id = params["city"]["region"].reject(&:empty?).map(&:to_i)
      # binding.pry
      if !@cities_name.empty?
        if !@regions_id.empty?
          @cities = @cities.where(id: @cities_name).or(@cities.where(region_id: @regions_id))
        else
          @cities = @cities.where(id: @cities_name)
        end
      elsif !@regions_id.empty?
        @cities = @cities.where(region_id: @regions_id)
      end
    end

    def set_city
      @city = City.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def city_params
      params.require(:city).permit(:name, :region_id)
    end
end
