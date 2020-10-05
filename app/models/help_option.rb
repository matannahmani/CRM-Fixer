class HelpOption < ApplicationRecord
  validates :descriptionvol, uniqueness: true, allow_blank: true
  validates :descriptioncall, uniqueness: true, allow_blank: true
  has_many :user_options, dependent: :destroy
  has_many :call_options, dependent: :destroy
  has_many :calls, through: :call_options
  has_many :users, through: :user_options
end
