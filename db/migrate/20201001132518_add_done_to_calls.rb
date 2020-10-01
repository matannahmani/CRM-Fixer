class AddDoneToCalls < ActiveRecord::Migration[5.2]
  def change
    add_column :calls, :done, :boolean
  end
end
