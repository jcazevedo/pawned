class CreatePlayers < ActiveRecord::Migration
  def change
    create_table(:players) do |t|
      ## Database authenticatable
      t.string   :email,              :null => false
      t.string   :encrypted_password, :null => false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Encryptable
      t.string   :password_salt

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      ## Lockable
      t.integer  :failed_attempts, :default => 0
      t.string   :unlock_token
      t.datetime :locked_at

      ## Roles mask
      t.integer  :roles_mask, :default => 0

      ## Other fields
      t.string   :name, :default => ""

      ## Le created_at and updated_at
      t.timestamps
    end

    add_index :players, :email,                :unique => true
    add_index :players, :reset_password_token, :unique => true
    add_index :players, :confirmation_token,   :unique => true
    add_index :players, :unlock_token,         :unique => true
  end
end
