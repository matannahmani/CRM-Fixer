class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :user, dependent: :nullify
  has_many :call, dependent: :nullify
  belongs_to :region
end
