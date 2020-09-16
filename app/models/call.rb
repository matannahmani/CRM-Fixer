class Call < ApplicationRecord
  before_validation :checkphone, :checkemail, :sethealth
  belongs_to :city
  has_many :call_option
  belongs_to :user, optional: true
  validates :name, presence: true
  validates :lastname, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :email, presence: true
  validates_inclusion_of :healthcheck, in: [true, false]

  def sethealth
    self.healthcheck ||= false
  end
end
