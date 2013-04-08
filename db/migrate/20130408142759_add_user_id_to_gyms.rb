class AddUserIdToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :user_id, :int
  end
end
