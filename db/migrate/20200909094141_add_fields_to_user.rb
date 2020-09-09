class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lastname, :string
    add_column :users, :name, :string
    add_column :users, :gender, :boolean
    add_column :users, :phone, :integer
    add_column :users, :address, :string
    add_column :users, :student, :boolean
    add_reference :users, :city, foreign_key: true
    add_column :users, :adminlevel, :integer, default: 0
    add_column :users, :israelid, :integer
  end
end
