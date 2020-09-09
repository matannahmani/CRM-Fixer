class AddHealthcheckToCall < ActiveRecord::Migration[5.2]
  def change
    add_column :calls, :healthcheck, :boolean
  end
end
