class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name,        limit: 50, :null => false, :default => ""
      t.string :source_type
      t.integer :user_id,                :null => false
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :signup_start_time
      t.datetime :signup_end_time
      t.integer :court_id
      t.string :activity_address,     limit: 100,:null => false, :default => ""
      t.integer :limit_num
      t.string :contact_name
      t.string :contact_telephone,   limit: 30, :null => false, :default => ""
      t.string :qq
      t.text :details
      t.string :status,                 :null => false, :default => "00"
      t.float :activity_cost

      t.timestamps
    end
    add_index :activities, :court_id
  end
end
