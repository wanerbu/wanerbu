class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :status,                 :null => false, :default => "00"
      t.string   :telephone_no,   limit: 30, :null => false, :default => ""

      t.timestamps
    end
  end
end
