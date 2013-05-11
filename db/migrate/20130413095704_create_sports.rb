class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string  :name, limit: 50,:null => false
      t.text    :intro
      t.integer :sort, limit: 3

      t.timestamps
    end
    add_index :sports,:name,              :unique => true
  end
end
