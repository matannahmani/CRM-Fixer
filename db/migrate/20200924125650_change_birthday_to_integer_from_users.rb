class ChangeBirthdayToIntegerFromUsers < ActiveRecord::Migration[5.2]
  def change
    def up
         change_column :users, :birthday, :date
     end

     def down
         change_column :users, :birthday, :integer
     end
  end
end
