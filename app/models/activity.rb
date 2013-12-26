class Activity < ActiveRecord::Base
  attr_accessible :activity_address, :activity_cost, :contact_name, :contact_telephone, :court_id, :details, :end_time, :limit_num, :name, :qq, :signup_end_time, :signup_start_time, :source_type, :start_time, :status, :user_id
  has_many :user_activites, :dependent => :destroy
  belongs_to :court
  belongs_to :user
end
