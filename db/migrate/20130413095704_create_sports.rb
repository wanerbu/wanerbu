class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.string :intro
      t.integer :sort

      t.timestamps
    end
  end
end
