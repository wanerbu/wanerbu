class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :city_id
      t.string :area, limit: 20

      t.timestamps
    end
  end
end
