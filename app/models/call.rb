class Call < ApplicationRecord
  before_validation :checkphone, :checkemail, :setdefault
  belongs_to :city, optional: true
  has_many :call_option, dependent: :destroy
  has_many :help_option, through: :call_option
  belongs_to :user, optional: true
  validates :name, presence: true
  validates :lastname, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :email, presence: true
  validates :availability, presence: true
  validates_inclusion_of :healthcheck, in: [true, false]
  validates_inclusion_of :done, in: [true, false]
  validate :opts?

  def opts?
    errors.add(:help_option, :blank, message: 'לא יכול להיות ריק') if call_option.empty?
  end

  def setdefault
    self.healthcheck ||= false
    self.done ||= false
  end

  def self.availabilitylist
    ["כל היום", "10:00-14:00", "14:00-18:00", "18:00-20:00"]
  end
end
