class AddDonetimeToCall < ActiveRecord::Migration[5.2]
  def change
    add_column :calls, :donetime, :date
  end
end
