class Call < ApplicationRecord
  belongs_to :city
  belongs_to :HelpOption
  belongs_to :user
end
