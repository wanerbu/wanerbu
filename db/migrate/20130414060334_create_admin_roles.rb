class CreateAdminRoles < ActiveRecord::Migration
  def change
    create_table :admin_roles do |t|
      t.integer :admin_id, null: false
      t.integer :role_id, null: false
    end

    add_index(:admin_roles, :admin_id)
    add_index(:admin_roles, :role_id)
  end
end
