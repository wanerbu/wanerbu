class GamePriceRule < ActiveRecord::Base
  #00 week
  #01 date
  attr_accessible :date_value, :end_time, :game_id, :price, :start_time, :rule_type, :week_value
  belongs_to :game
  #TODO validation for game price rule
  #同一天同一场次同一时段的同一类型规则只能有一个
  #时段区间必须是预订单位的整数倍
  #时段区间必须在场馆的营业时间之间
  #如果所属场地为按人次预订，则start_time和end_time不作为计算价格条件，默认为全天
  validates :price, 
    :presence => true,
    :numericality => { :greater_than_or_equal_to => 0 }
end
