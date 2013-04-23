class CreateSportProperties < ActiveRecord::Migration
  def change
    create_table :sport_properties do |t|
      t.integer :sport_id
      t.integer :property_id
      t.string :default_value, limit: 20
      t.integer :scope,limit: 9
      t.boolean :required

      t.timestamps
    end
  end
end
