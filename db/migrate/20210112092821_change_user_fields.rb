class ChangeUserFields < ActiveRecord::Migration[5.2]
    def up
         change_column :users, :campus, :string, array: false
         change_column :users, :availability, :string, array: false
     end

     def down
         change_column :users, :availability, :string, array: true
         change_column :users, :campus, :string, array: true
     end
end
