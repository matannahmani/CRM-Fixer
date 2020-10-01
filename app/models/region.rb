class Region < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :cities, dependent: :destroy
  has_many :call, through: :cities
end
