class RemoveActiveFromCallOption < ActiveRecord::Migration[5.2]
  def change
    remove_column :call_options, :active, :destroy
    # remove_column :help_options, :active, :destroy
  end
end
