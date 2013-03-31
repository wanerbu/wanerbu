# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
class DeviseCreateAdmins < ActiveRecord::Migration
  def change
    create_table(:admins) do |t|
      ## 自定义字段
      t.string :login_id, limit: 16
      t.string :first_name, limit: 10
      t.string :last_name, limit: 10
      t.string :telephone_no, limit: 15
      t.string :status, limit: 2
      t.datetime :deleted_at
      
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

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
      t.string :password_salt

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      t.string :authentication_token


      t.timestamps
    end

    add_index :admins, :email,                :unique => true
    add_index :admins, :reset_password_token, :unique => true
    add_index :admins, :confirmation_token,   :unique => true
    add_index :admins, :unlock_token,         :unique => true
    add_index :admins, :authentication_token, :unique => true
    add_index :admins, :login_id,             :unique => true
  end
end
