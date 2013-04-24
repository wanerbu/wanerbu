class CreateCourtProperties < ActiveRecord::Migration
  def change
    create_table :court_properties do |t|
      t.integer :court_id
      t.integer :property_id
      t.string :property_value, limit: 20

      t.timestamps
    end
  end
end
