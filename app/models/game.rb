class Game < ActiveRecord::Base
  attr_accessible :court_id, :default_price, :name, :sort,:can_reservation,:max_people
  has_many :game_price_rules, :dependent => :destroy
  has_many :game_reservation_rules, :dependent => :destroy
  belongs_to :court
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
  #如果该场次在该时间段有预订，返回true,否则返回false
  def has_reservation(start_time,end_time)
    s_time = start_time.to_formatted_s(:db) 
    e_time = end_time.to_formatted_s(:db) 
    r = false
    reservations = Reservation.where("(start_time < ? and end_time >= ? and game_id = ?)",e_time,e_time,self.id)
    if reservations != nil
      reservations.each do |reservation|
        order = Order.find(reservation.order_id)
        if (order.status <= '50')
          r = true;
        end
      end
    end
    return r
  end
  def get_remain_people_num(start_time) 
    date = start_time.to_date
    reserved_num = Reservation.joins(:order).where("orders.status <= '50' and date(reservations.start_time) = ? and reservations.game_id = ?",date,self.id).sum("reservations.people_num")
    return self.max_people - reserved_num
  end
end
