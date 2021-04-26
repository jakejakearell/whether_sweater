class AddEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_column :users, :api_key, :string
    remove_column :users, :username, :string
  end
end
