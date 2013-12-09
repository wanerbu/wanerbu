class Reservation < ActiveRecord::Base
  attr_accessible :end_time, :game_id, :order_id, :price,  :start_time
  #添加association
  belongs_to :order
  belongs_to :game
end
