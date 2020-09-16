class HelpOptionsController < ApplicationController
  before_action :set_help_option, only: [:show, :edit, :update, :destroy]
  before_action :checkadmin

  # GET /help_options
  # GET /help_options.json
  def index
    @help_options = HelpOption.all
  end

  # GET /help_options/1
  # GET /help_options/1.json
  def show
  end

  # GET /help_options/new
  def new
    @help_option = HelpOption.new
  end

  # GET /help_options/1/edit
  def edit
  end

  # POST /help_options
  # POST /help_options.json
  def create
    @help_option = HelpOption.new(help_option_params)

    respond_to do |format|
      if @help_option.save
        format.html { redirect_to @help_option, notice: "תצוגה #{CREATE_MSG}" }
        format.json { render :show, status: :created, location: @help_option }
      else
        format.html { render :new }
        format.json { render json: @help_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /help_options/1
  # PATCH/PUT /help_options/1.json
  def update
    respond_to do |format|
      if @help_option.update(help_option_params)
        format.html { redirect_to @help_option, notice: "תצוגה #{UPDATE_MSG}" }
        format.json { render :show, status: :ok, location: @help_option }
      else
        format.html { render :edit }
        format.json { render json: @help_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /help_options/1
  # DELETE /help_options/1.json
  def destroy
    @help_option.destroy
    respond_to do |format|
      format.html { redirect_to help_options_url, notice: "תצוגה #{DESTROY_MSG}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help_option
      @help_option = HelpOption.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def help_option_params
      params.require(:help_option).permit(:descriptionvol, :descriptioncall)
    end
end
