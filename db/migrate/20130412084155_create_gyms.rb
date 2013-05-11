class CreateGyms < ActiveRecord::Migration
  def up
    create_table :gyms do |t|
      t.string   :name,        limit: 50, :null => false, :default => ""
      t.integer  :user_id,                :null => false
      t.text     :intro,                  :null => false
      t.string   :address,     limit: 100,:null => false, :default => ""
      t.string   :telephone,   limit: 30, :null => false, :default => ""
      t.time     :open_time,              :null => false, :default => ""
      t.time     :close_time,             :null => false, :default => ""
      t.float    :score,                  :null => false, :default => 0
      t.string   :status,                 :null => false, :default => "00"
      t.string   :reject_reason,          limit: 100
      t.text     :history_log
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :gyms,:user_id,              :unique => true
  end
end
