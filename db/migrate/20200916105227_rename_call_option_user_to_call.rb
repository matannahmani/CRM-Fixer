class RenameCallOptionUserToCall < ActiveRecord::Migration[5.2]
  def change
  rename_column :call_options, :user_id, :call_id
  end
end
