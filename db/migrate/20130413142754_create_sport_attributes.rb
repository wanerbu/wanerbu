class CreateSportAttributes < ActiveRecord::Migration
  def change
    create_table :sport_attributes do |t|
      t.integer :sport_id
      t.integer :attribute_id
      t.string :default_value, limit: 20
      t.integer :scope,limit: 1
      t.boolean :required

      t.timestamps
    end
  end
end
