class AddRegistrationAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :registration_confirmed, :boolean, :default => false
    add_column :users, :registration_token, :string
  end
end
