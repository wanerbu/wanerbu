class GymImage < ActiveRecord::Base
  attr_accessible :gym_id, :image, :intro
  mount_uploader :image, ImageUploader
  #添加association
  belongs_to :gym
end
