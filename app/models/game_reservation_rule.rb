class GameReservationRule < ActiveRecord::Base
  attr_accessible :can_reservation, :date_value, :end_time, :game_id, :rule_type, :start_time, :week_value
  belongs_to :game
  #同一天同一场次同一时段的同一类型规则只能有一个
  #时段区间必须是预订单位的整数倍
  #时段区间必须在场馆的营业时间之间
  #如果所属场地为按人次预订，则start_time和end_time不作为计算是否预订条件，默认为全天
end
