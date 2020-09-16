class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :checkphone, :checkemail, :healthauto
  after_create { self.healthcheck = true }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { in: 3..20 }
  validates :lastname, presence: true, length: { in: 3..20 }
  validates :phone, presence: true, numericality: true
  validates :city_id, presence: true
  validates :address, presence: true
  validates_inclusion_of :healthcheck, in: [true, false]
  validates_inclusion_of :student, in: [true, false]
  validates :adminlevel, presence: true
  validates :israelid, presence: true, uniqueness: true, numericality: true
  has_many :call
  has_many :user_option
  belongs_to :city
  ADMIN = 3 # OWNER
  SUPERVISOR = 2 # SUPERVISOR
  CALLER = 1 # CALLER
  VOLUENNTER = 0 # VOL

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

  def admin_to_s
    return "מתנדב" if adminlevel == 0
    return "טלפן" if adminlevel == 1
    return "מנהל מחוז" if adminlevel == 2
    return "מנהל ארצי" if adminlevel == 3 || adminlevel == 4
  end

  def healthauto
    self.healthcheck = true
  end
end
