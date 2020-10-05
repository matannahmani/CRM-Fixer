class CreateCalloptions < ActiveRecord::Migration[5.2]
  def change
    create_table :call_options do |t|
      t.belongs_to :call
      t.belongs_to :help_option
      t.timestamps
    end
  end
end
