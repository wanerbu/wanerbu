class CreateGymImages < ActiveRecord::Migration
  def change
    create_table :gym_images do |t|
      t.integer :gym_id
      t.string :image
      t.string :intro, limit: 2

      t.timestamps
    end
    add_index :gym_images, :gym_id
  end
end
