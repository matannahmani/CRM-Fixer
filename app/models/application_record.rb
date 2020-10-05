class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def checkphone
    reg = /^((\+|00)?972\-?|0)(([23489]|[57]\d)\-?\d{7})$/
    if !self.phone.match(reg)
      errors.add(:phone, :blank, message: 'אנא הזן מספר טלפון ישראלי תקני')
    end
  end

  def checkemail
    if !self.email.match(URI::MailTo::EMAIL_REGEXP)
      errors.add(:email, :blank, message: 'אנא הזן כתובת דוא"ל תקנית')
    end
  end

end
