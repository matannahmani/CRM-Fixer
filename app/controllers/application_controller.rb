class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  CALL_TAKEN = "הקריאה נלקחה בהצלחה!"
  CALL_UNTAKEN = "הקריאה שוחררה בהצלחה!"
  CALL_UNAUTH = "אינך בעל הקריאה!"
  CALL_UPDATED = "הקריאה עודכנה בהצלחה!"
  CALL_DESTROYED = "הקריאה נמחקה בהצלחה!"
  CALL_ERROR = "שגיאה"
  CALL_INSUFFICIENT = "אינך רשאי לבצע פעולה זאת!"

  def checkadmin
    redirect_to :root, notice: CALL_INSUFFICIENT unless current_user.issuper?
  end

  def after_sign_up_path_for(resource)
    pry.byebug
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :student, :lastname, :phone, :address, :israelid, :city_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :student, :lastname, :phone, :address, :israelid, :city_id])
  end
end
