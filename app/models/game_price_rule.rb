class GamePriceRule < ActiveRecord::Base
  attr_accessible :date_value, :end_time, :game_id, :price, :start_time, :rule_type, :week_value
  belongs_to :game
end
