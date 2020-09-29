class HelpOption < ApplicationRecord
  validates :descriptionvol, uniqueness: true, allow_blank: true
  validates :descriptioncall, uniqueness: true, allow_blank: true
  has_many :user_option, dependent: :destroy
  has_many :call_option, dependent: :destroy
  has_many :call, through: :call_option
  has_many :user, through: :user_option
end
