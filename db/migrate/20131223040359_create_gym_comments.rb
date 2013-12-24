class CreateGymComments < ActiveRecord::Migration
  def change
    create_table :gym_comments do |t|
      t.integer :gym_id
      t.integer :user_id
      t.float   :score,                  :null => false, :default => 0
      t.text    :comment

      t.timestamps
    end
  end
end
