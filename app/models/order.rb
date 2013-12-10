class Order < ActiveRecord::Base
  attr_accessible :status, :user_id,:telephone_no
  #添加association
  belongs_to :user
  has_many   :reservations, :dependent => :destroy

end
