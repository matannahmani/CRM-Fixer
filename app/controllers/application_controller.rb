class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :student, :lastname, :phone, :address, :israelid, :city_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :student, :lastname, :phone, :address, :israelid, :city_id])
  end
end
