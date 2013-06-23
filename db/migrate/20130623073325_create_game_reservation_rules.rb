class CreateGameReservationRules < ActiveRecord::Migration
  def change
    create_table :game_reservation_rules do |t|
      t.string :rule_type
      t.integer :week_value
      t.date :data_value
      t.time :start_time
      t.time :end_time
      t.boolean :can_reservation

      t.timestamps
    end
  end
end
