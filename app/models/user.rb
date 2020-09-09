class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
end
