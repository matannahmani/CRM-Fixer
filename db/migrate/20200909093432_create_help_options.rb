class CreateHelpOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :help_options do |t|
      t.string :descriptionvol
      t.string :descriptioncall
      t.timestamps
    end
  end
end
