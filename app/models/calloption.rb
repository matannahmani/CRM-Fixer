class Calloption < ApplicationRecord
  belongs_to :user
  belongs_to :help_option
  validates :active, presence: true
end
