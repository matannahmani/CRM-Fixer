class CallOption < ApplicationRecord
  belongs_to :call
  belongs_to :help_option
  validates :active, presence: true
end
