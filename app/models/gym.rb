class Gym < ActiveRecord::Base
  # attr_accessible :title, :body
 attr_accessible :name,:intro,:address,:telephone,:open_time,:close_time,:score,:status,:deleted_at

end
