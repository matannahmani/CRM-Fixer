class UserOption < ApplicationRecord
  belongs_to :user
  belongs_to :help_option
end
