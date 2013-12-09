class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :game_id
      t.integer :order_id
      t.datetime :start_time
      t.datetime :end_time
      t.float :price

      t.timestamps
    end
  end
end
