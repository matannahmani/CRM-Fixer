class AddReferencesToCity < ActiveRecord::Migration[5.2]
  def change
    add_reference :cities, :region, foreign_key: true
  end
end
