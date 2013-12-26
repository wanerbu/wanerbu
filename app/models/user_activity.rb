class UserActivity < ActiveRecord::Base
  attr_accessible :activity_id, :join_num, :user_id
  belongs_to :activity
  belongs_to :user
end
