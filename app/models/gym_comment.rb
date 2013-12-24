class GymComment < ActiveRecord::Base
  attr_accessible :comment, :gym_id, :user_id, :score
  #添加association
  belongs_to :gym
  belongs_to :user
end
