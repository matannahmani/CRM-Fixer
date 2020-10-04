class AddHamalnmoreToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :helpoperations, :boolean
    add_column :users, :solidaritycampusaddress, :string
  end
end
