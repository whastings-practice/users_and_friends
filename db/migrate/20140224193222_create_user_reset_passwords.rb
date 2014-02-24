class CreateUserResetPasswords < ActiveRecord::Migration
  def change
    create_table :user_reset_passwords do |t|
      t.integer :user_id, :null => false
      t.string :auth_token, :null => false

      t.timestamps
    end
    add_index :user_reset_passwords, :auth_token
  end
end
