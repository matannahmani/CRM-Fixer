class HelpOption < ApplicationRecord
  validates :descriptionvol, uniqueness: true, presence: true, length: { in: 3..120 }
  validates :descriptioncall, uniqueness: true, presence: true, length: { in: 3..120 }
end
