class Activity < ActiveRecord::Base
  #Enumerize使用
  extend Enumerize
  attr_accessible :activity_address, :activity_cost, :activity_type,:contact_name, :contact_telephone, :court_id, :details, :end_time, :limit_num, :name, :qq, :signup_end_time, :signup_start_time, :source_type, :start_time, :status, :user_id,:province_id,:city_id,:area_id,:logo
  mount_uploader :logo, ImageUploader
  #Enumerize使用
  enumerize :activity_type, in: Wanerbu::CodeDefine::ACTIVITY_TYPE, default: :sport
  has_many :user_activites, :dependent => :destroy
  belongs_to :court
  belongs_to :user
end
