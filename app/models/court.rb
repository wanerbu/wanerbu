class Court < ActiveRecord::Base
  attr_accessible :gym_id, :min_unit, :sport_id,:property_ids, :court_properties_attributes
  #添加association
  belongs_to :gym
  belongs_to :sport
  has_many :court_properties, :dependent => :destroy
  accepts_nested_attributes_for :court_properties, :allow_destroy => true
  #TODO 场馆添加项目不能重复的验证
end
