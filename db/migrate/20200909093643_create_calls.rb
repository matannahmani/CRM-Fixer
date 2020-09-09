class CreateCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :calls do |t|
      t.string :name
      t.string :lastname
      t.integer :phone
      t.string :address
      t.references :city, foreign_key: true
      t.string :email
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
