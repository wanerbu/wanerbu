class Court < ActiveRecord::Base
  #Enumerize使用
  extend Enumerize
  attr_accessible :gym_id, :min_unit, :sport_id,:reservation_type,:property_ids, :court_properties_attributes
  #Enumerize使用
  enumerize :reservation_type, in: Wanerbu::CodeDefine::COURT_RESERVATION_TYPE, default: :according_time
  #添加association
  belongs_to :gym
  belongs_to :sport
  has_many :court_properties, :dependent => :destroy
  has_many :games, :dependent => :destroy
  accepts_nested_attributes_for :court_properties, :allow_destroy => true
  #TODO 场馆添加项目不能重复的验证
  # validations
  validates :sport_id, 
    :presence => true
  validates :reservation_type, 
    :presence => true
  validates :min_unit, 
    :presence => true,
    :numericality => { :greater_than_or_equal_to => 0 }
end
