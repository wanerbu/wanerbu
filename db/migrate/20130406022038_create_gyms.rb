class CreateGyms < ActiveRecord::Migration
  def change
    create_table :gyms do |t|
      t.string :name, limit: 50,:null => false, :default => ""
      t.text :intro
      t.string :address, limit: 100,:null => false, :default => ""
      t.string :telephone, limit: 30,:null => false, :default => ""
      t.time :open_time,:null => false, :default => ""
      t.time :close_time,:null => false, :default => ""
      t.float :score,:null => false, :default => 0
      t.string :status,:null => false, :default => "00"
      t.datetime :deleted_at,:null => false, :default => ""

      t.timestamps
    end
  end
end
