class AddMorefieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :birthday, :date
    add_column :users, :joinlocal, :boolean
    add_column :users, :langauges, :string, array: true
    add_column :users, :getupdates, :boolean
    add_column :users, :lastcontact, :date
    add_column :users, :contactname, :string
    add_column :users, :keepvolunteer, :boolean
    add_column :users, :pastvolunteervolume, :integer
    add_column :users, :volunteerusefull, :boolean
    add_column :users, :availability, :string, array: true
    add_column :users, :workfield, :string
    add_column :users, :specality, :string
    add_column :users, :pastvolunteer, :string
    add_column :users, :helplocal, :boolean
    add_column :users, :helpcalls, :boolean
    add_column :users, :solidaritycampus, :boolean
    add_column :users, :campus, :string, array: true
    add_column :users, :campusactivity, :string
    add_column :users, :studentactivist, :boolean
    add_column :users, :intrestedinsolidarity, :boolean
    add_column :users, :localwhatsapp, :boolean
    add_column :users, :othermentions, :string
  end
end
