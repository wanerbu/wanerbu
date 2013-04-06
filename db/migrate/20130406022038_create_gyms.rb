class CreateGyms < ActiveRecord::Migration
  def change
    create_table :gyms do |t|

      t.timestamps
    end
  end
end
