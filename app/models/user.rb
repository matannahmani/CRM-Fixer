class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # before_validation :checkphone, :checkemail, :checkage?
  before_validation :checkemail
  after_create { self.healthcheck = true }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { in: 3..20 }
  validates :lastname, presence: true, length: { in: 3..20 }
  validates :phone, presence: true, numericality: true
  validates :city_id, presence: true
  validates :address, presence: true
  validates_inclusion_of :gender, in: [true, false]
  validates_inclusion_of :student, in: [true, false]
  validates :adminlevel, presence: true
  validates :healthcheck, presence: true
  validates :getupdates, presence: true
  validates :israelid, presence: true, uniqueness: true, numericality: true
  has_many :call, dependent: :nullify
  has_many :user_options, dependent: :destroy
  has_many :help_options, through: :user_options
  validate :opts?
  belongs_to :city, optional: true # needs to be reassinged if city has been destroyed
  ADMIN = 3 # OWNER
  SUPERVISOR = 2 # SUPERVISOR
  CALLER = 1 # CALLER
  VOLUENNTER = 0 # VOL

  def opts?
    # errors.add(:help_options, :blank, message: 'לא יכול להיות ריק') if user_options.empty?
  end
  def checkage?
    errors.add(:birthday, :blank, message: 'הצטרפות פתוחה רק לגילי 14-75') unless birthday.in?(Date.today.year - 75..Date.today.year - 14)
  end
  def fullname
    name + " " + lastname
  end

  def fullnameid
    name + " " + lastname + " " + israelid
  end

  def isadmin?
    adminlevel == 3
  end

  def issuper?
    adminlevel == 2 || adminlevel == 3
  end

  def iscaller?
    adminlevel == 1
  end

  def isvol?
    adminlevel == 0
  end

  def self.availabilitylist
    ["כל השבוע", "ראשון", "שני", "שלישי", "רביעי", "חמישי", "שישי", "שבת"]
  end

  def lang_s
    result = ""
    langauges.each { |i| result << "#{i}, " unless i.empty?}
    result[0..-3]
  end

  def aval_s
    result = ""
    availability.each { |i| result << "#{i}, " unless i.empty?}
    result[0..-3]
  end

  def gender? # true = MALE | false = FEMALE
    gender ? "גבר" : "אישה"
  end

  def admin_to_s
    return "מתנדב" if adminlevel.zero?
    return "טלפן" if adminlevel == 1
    return "מנהל מחוז" if adminlevel == 2
    return "מנהל ארצי" if adminlevel == 3 || adminlevel == 4
  end
end
