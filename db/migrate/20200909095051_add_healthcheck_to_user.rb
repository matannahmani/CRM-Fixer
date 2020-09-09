class AddHealthcheckToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :healthcheck, :boolean
  end
end
