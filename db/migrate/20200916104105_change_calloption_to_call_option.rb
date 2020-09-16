class ChangeCalloptionToCallOption < ActiveRecord::Migration[5.2]
  def change
    rename_table :calloptions, :call_options
  end
end
