class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :court_id
      t.string :name
      t.integer :sort
      t.float :default_price

      t.timestamps
    end
  end
end
