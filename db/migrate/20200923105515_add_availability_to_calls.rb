class AddAvailabilityToCalls < ActiveRecord::Migration[5.2]
  def change
    add_column :calls, :availability, :string, array: true
  end
end
