class Court < ActiveRecord::Base
  attr_accessible :gym_id, :min_unit, :sport_id
  #添加association
  belongs_to :gym
  belongs_to :sport
end
