class CreateGamePriceRules < ActiveRecord::Migration
  def change
    create_table :game_price_rules do |t|
      t.integer :game_id 
      t.string  :rule_type,       limit: 2, :null => false, :default => "00"
      t.integer :week_value, limit: 1
      t.date    :date_value
      t.time    :start_time
      t.time    :end_time
      t.float   :price

      t.timestamps
    end
    add_index :game_price_rules, :game_id
  end
end
