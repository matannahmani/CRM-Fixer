class CreateUserOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_options do |t|
      t.belongs_to :user
      t.belongs_to :help_option
      t.timestamps
    end
  end
end
