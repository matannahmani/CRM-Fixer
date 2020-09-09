class Call < ApplicationRecord
  belongs_to :city
  # belongs_to :CallOption
  belongs_to :user, optional: true
end
