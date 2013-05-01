class Gym < ActiveRecord::Base
  #Enumerize使用
  extend Enumerize
  # attr_accessible :title, :body
 attr_accessible :name,:intro,:address,:telephone,:open_time,:close_time,:score,:status,:deleted_at

  # 逻辑删除
  acts_as_paranoid

  #添加association
  belongs_to :user
  has_many   :courts
  
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
    :length => { :in => 0..15 }, 
    :format => { if: "telephone.present?", with: Wanerbu::Common::FORMAT_TELEPHONE}
  validate :valid_time

 def valid_time
   if close_time <= open_time
#TODO error msg 的显示需调查
     self.errors.add :close_time, ' has to be after close time'
   end
 end 
  #Enumerize使用
  enumerize :status, in: Wanerbu::CodeDefine::GYM_STATUS, default: :draft
end
