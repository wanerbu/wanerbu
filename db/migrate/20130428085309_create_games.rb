class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :court_id
      t.string :name, limit: 20
      t.integer :sort, limit: 3
      t.float :default_price, default: 0

      t.timestamps
    end
  end
end
