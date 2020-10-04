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
  CALL_CREATE = "הקריאה נלקחה נפתחה!"
  UPDATE_MSG = "עודכנה בהצלחה!"
  DESTORY_MSG = "נמחקה בהצלחה!"
  CREATE_MSG = "נוצרה בהצלחה!"
  def checkadmin
    redirect_to :root, notice: CALL_INSUFFICIENT unless current_user.issuper?
  end

  def checkadminuser
    redirect_to :root, notice: CALL_INSUFFICIENT unless current_user.adminlevel.positive?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :student, :lastname, :phone, :address, :israelid, :gender, :birthday, :healthcheck, :getupdates, :city_id, :help_option_ids => [], :langauges => []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :student, :lastname, :phone, :address, :israelid, :gender, :birthday, :healthcheck, :getupdates, :city_id, :help_option_ids => [], :langauges => []])
  end
end
