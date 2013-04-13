class CreateSportReports < ActiveRecord::Migration
  def change
    create_table :sport_reports do |t|

      t.timestamps
    end
  end
end
