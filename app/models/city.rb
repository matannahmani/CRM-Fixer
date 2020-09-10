class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :user
  has_many :call
end
