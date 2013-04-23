class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.integer :sport_id,:null => false
      t.integer :gym_id,:null => false
      t.float :min_unit, default: 0.5

      t.timestamps
    end
  end
end
