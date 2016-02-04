class RenameAdminUsers < ActiveRecord::Migration
  def self.up
    remove_index :admin_users, :email
    remove_index :admin_users, :reset_password_token

    rename_table :admin_users, :users

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end

 def self.down
   remove_index :users, :email
   remove_index :users, :reset_password_token

   rename_table :users, :admin_users

    add_index :admin_users, :email,                unique: true
    add_index :admin_users, :reset_password_token, unique: true
 end
end
