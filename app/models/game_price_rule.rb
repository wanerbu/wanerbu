class GamePriceRule < ActiveRecord::Base
  attr_accessible :date_value, :end_time, :game_id, :price, :start_time, :rule_type, :week_value
  belongs_to :game
  #TODO validation for game price rule
  validates :price, 
    :presence => true,
    :numericality => { :greater_than_or_equal_to => 0 }
end
