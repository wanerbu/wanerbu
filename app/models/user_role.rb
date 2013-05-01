class UserRole < ActiveRecord::Base
  attr_accessible :role_id, :user_id
  #添加association
  belongs_to :user
  belongs_to :role
end
