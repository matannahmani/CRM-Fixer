class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :checkphone
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { in: 3..20 }
  validates :lastname, presence: true, length: { in: 3..20 }
  validates :phone, presence: true, numericality: true
  validates :city_id, presence: true
  validates :address, presence: true
  validates :student, presence: true
  validates :healthcheck, presence: true
  validates :adminlevel, presence: true
  validates :israelid, presence: true, numericality: true
  has_many :call
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
end
