# coding: utf-8
class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :province, limit: 20

      t.timestamps
    end
  end
end
