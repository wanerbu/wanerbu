class Gym < ActiveRecord::Base
  #Enumerize使用
  extend Enumerize
 attr_accessible :name,:intro,:address,:telephone,:open_time,:close_time,:status,:deleted_at,:user_id,:history_log,:reason,:logo,:province_id,:city_id,:area_id
  mount_uploader :logo, ImageUploader
  #Enumerize使用
  enumerize :status, in: Wanerbu::CodeDefine::GYM_STATUS, default: :draft
  # 如果是逻辑删除，删除后该用户将不能再建场馆因为user_id uniquness 验证失败
  # 逻辑删除
  #acts_as_paranoid

  #添加association
  belongs_to :user
  has_many   :courts
  has_many   :gym_images
  has_many   :gym_comments,:order => "gym_comments.created_at DESC"
  # validations
  validates :name, 
    :presence => true,
    :length => { :in => 1..50 }
  validates :intro, 
    :presence => true,
    :length => { :minimum => 6 }
  validates :address, 
    :presence => true,
    :length => { :in => 1..50 }
  validates :telephone, 
    :presence => true,
    :length => { :in => 0..15 }, 
    :format => { if: "telephone.present?", with: Wanerbu::Common::FORMAT_TELEPHONE}
  #验证一个用户只能创建一个场馆
  validates :user_id, 
    :uniqueness => true
  validates :open_time, 
    :presence => true
  validates :close_time, 
    :presence => true
  validate :valid_time

 def valid_time
   if close_time.present? && open_time.present? && close_time <= open_time
     self.errors.add(:close_time, :close_time_less_than_open_time)
   end
 end
 def score
    s = self.gym_comments.average("score")
    s = s.round(1) if s.present?
 end
 def getFullAddress
  full_address = City.find(self.city_id).city + Area.find(self.area_id).area + self.address 
 end
end
