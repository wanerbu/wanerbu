class GameReservationRule < ActiveRecord::Base
  attr_accessible :can_reservation, :date_value, :end_time, :game_id, :rule_type, :start_time, :week_value
  belongs_to :game
end
