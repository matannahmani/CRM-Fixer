class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def checkphone
    reg = /^((\+|00)?972\-?|0)(([23489]|[57]\d)\-?\d{7})$/
    if !self.phone.match(reg)
      true
    else
      errors.add(:base, 'Not israeli phone')
      false
    end
  end

  def checkemail
    if !self.email.match(URI::MailTo::EMAIL_REGEXP)
      true
    else
      errors.add(:base, 'Bad email')
      false
    end
  end
end
