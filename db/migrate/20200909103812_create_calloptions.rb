class CreateCalloptions < ActiveRecord::Migration[5.2]
  def change
    create_table :calloptions do |t|
      t.references :user, foreign_key: true
      t.references :help_option, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
