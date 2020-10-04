class ChangeSolidaritycampusadressName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :solidaritycampusaddress, :solidaritylocaladdress
  end
end
