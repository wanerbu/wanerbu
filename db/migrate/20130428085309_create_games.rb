lass CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :court_id
      t.string :name, limit: 20
      t.integer :sort, limit: 3
      t.boolean :can_reservation
      t.float :default_price, default: 0

      t.timestamps
    end
    add_index :games, :court_id
  end
end
