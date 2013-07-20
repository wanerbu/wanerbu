class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :province_id
      t.string :city, limit: 20

      t.timestamps
    end
  end
end
