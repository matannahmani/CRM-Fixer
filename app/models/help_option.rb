class HelpOption < ApplicationRecord
  validates :descriptionvol, uniqueness: true, presence: true, length: { in: 3..120 }
  validates :descriptioncall, uniqueness: true, presence: true, length: { in: 3..120 }
  has_many :user_option
  has_many :call_option
  has_many :call, :through => :call_option
  has_many :user, :through => :user_option
end
