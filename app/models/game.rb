class Game < ActiveRecord::Base
  #Enumerize使用
 # extend Enumerize
  attr_accessible :court_id, :default_price, :name, :sort,:can_reservation
  #Enumerize使用
 # enumerize :can_reservation, in: Wanerbu::CodeDefine::GAME_CAN_RESERVATION, default: :can_reservation_true
  # validations
  validates :court_id, 
    :presence => true
  validates :name, 
    :presence => true,
    :length => { :in => 1..50 }
  validates :default_price, 
    :presence => true,
    :numericality => { :greater_than_or_equal_to => 0 }
  validates :sort, 
    :presence => true,
    :numericality => { :only_integer => true,:greater_than => 0 }
end
