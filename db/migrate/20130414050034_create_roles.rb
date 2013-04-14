class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, limit: 20, null: false
      t.integer :sort, limit: 3, null: false, default: 1
      t.string :functions, limit: 300

      t.datetime :deleted_at

      t.timestamps
    end

    add_index :roles, :name, :unique => true
  end
end
