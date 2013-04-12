class Gym < ActiveRecord::Base
  #Enumerize使用
  extend Enumerize
  # attr_accessible :title, :body
 attr_accessible :name,:intro,:address,:telephone,:open_time,:close_time,:score,:status,:deleted_at

  # 逻辑删除
  acts_as_paranoid

  #添加association
  belongs_to :user
  
  validates :telephone, :length => { :in => 0..15 }
  validates :telephone, :format => { if: "telephone.present?", with: Wanerbu::Common::FORMAT_TELEPHONE}
  #Enumerize使用
  enumerize :status, in: Wanerbu::CodeDefine::GYM_STATUS, default: :draft
end
