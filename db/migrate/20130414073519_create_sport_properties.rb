class CreateSportProperties < ActiveRecord::Migration
  def change
    create_table :sport_properties do |t|
      t.integer :sport_id
      t.integer :property_id
      t.string  :default_value, limit: 20
      t.integer :scope,limit: 9

      t.timestamps
    end
    add_index(:sport_properties, [:sport_id, :property_id], :unique => true)
  end
end
