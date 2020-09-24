class RemoveActiveFromUserOption < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_options, :active, :destroy
  end
end
