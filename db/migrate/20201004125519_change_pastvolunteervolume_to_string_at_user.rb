class ChangePastvolunteervolumeToStringAtUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :pastvolunteervolume, :string
  end
end
