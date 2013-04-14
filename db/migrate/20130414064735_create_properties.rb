class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name, limit: 20,:null => false
      t.string :unit, limit: 6,:null => false
      t.string :intro, limit:50
      t.timestamps
    end
  end
end
