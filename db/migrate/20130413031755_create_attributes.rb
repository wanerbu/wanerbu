class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :name
      t.string :unit
      t.string :intro

      t.timestamps
    end
  end
end
