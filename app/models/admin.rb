# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 系统管理员
#
class Admin < ActiveRecord::Base

  extend Enumerize
  #include Wanerbu::Common::RoleAbility

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :encryptable,  :lockable, :timeoutable
         # TODO dairg 是否确认配置
         # :confirmable,

  # 逻辑删除
  acts_as_paranoid

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :password_salt,
                  :login_id,
                  :first_name,
                  :last_name,
                  :telephone_no,
                  :status
 
  ### validations
  validates :login_id, :password_confirmation,  :presence => true, on: :create
  validates :login_id, :length => { :in => 6..16 }, if: "login_id.present?", on: :create
  validates :login_id, :format => { if: "login_id.present?", with: Wanerbu::Common::FORMAT_LOGIN_ID }, on: :create
  validates :password, :format => { if: "password.present?", with: Wanerbu::Common::FORMAT_PASSWORD }, on: :create
  validates :password_confirmation, :format => { if: "password_confirmation.present?", with: Wanerbu::Common::FORMAT_PASSWORD }, on: :create
  validates :first_name, :last_name, :length => { :in => 0..10 }
  validates :telephone_no, :length => { :in => 0..15 }
  validates :telephone_no, :format => { if: "telephone_no.present?", with: Wanerbu::Common::FORMAT_TELEPHONE}

  # validates :status, :format => { if: "status.present?", with: Wanerbu::Common::FORMAT_TELEPHONE}
  enumerize :status, in: Wanerbu::CodeDefine::ADMIN_STATUS, default: :active

  ### Relations
  has_many(:admin_roles)
  has_many(:roles, through: :admin_roles)
 
  before_save do
  end

  # 姓名
  def name
    name = ''
    name += self.first_name + ' ' if self.first_name
    name += self.last_name if self.last_name
    return name
  end
end
