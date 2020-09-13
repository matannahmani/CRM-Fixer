class Call < ApplicationRecord
  before_validation :checkphone, :checkemail
  belongs_to :city
  # belongs_to :CallOption
  belongs_to :user, optional: true
  validates :name, presence: true
  validates :lastname, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :email, presence: true
  validates_inclusion_of :healthcheck, in: [true, false]
end
