class RenameCalloptionToCallOption < ActiveRecord::Migration[5.2]
  def change
    def self.up
      rename_table :Calloption, :CallOption
    end

    def self.down
      rename_table :CallOption, :Calloption
    end
  end
end
