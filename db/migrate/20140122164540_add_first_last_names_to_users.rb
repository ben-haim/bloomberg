class AddFirstLastNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :full_name, :string 
    add_column :users, :password_confirmation, :string
  end
end
