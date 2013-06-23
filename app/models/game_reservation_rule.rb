class GameReservationRule < ActiveRecord::Base
  attr_accessible :can_reservation, :data_value, :end_time, :rule_type, :start_time, :week_value
end
