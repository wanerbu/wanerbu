# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 系统管理员
#
# TODO dairg 将来这里要删除

require 'role_ability'

class Admin < ActiveRecord::Base

  extend Enumerize
  include Wanerbu::Common::RoleAbility

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :encryptable,  :lockable, :timeoutable
         # TODO dairg 是否确认配置
         # :confirmable,

  # 逻辑删除
  acts_as_paranoid

  ### 常量
  SUPER_ADMIN_ID = 1

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

  ### DefaultScope
  default_scope order("login_id ASC")

  ### Scopes
  scope :except_super_admin, where('id <> ?', SUPER_ADMIN_ID)
 
  before_save do
  end

  # 姓名
  def name
    name = ''
    name += self.first_name + ' ' if self.first_name
    name += self.last_name if self.last_name
    return name
  end

  ## 是否是唯一的超级管理员
  def only_super_admin?
    self.id == SUPER_ADMIN_ID
  end

  def ability?(function)
    # 如果是唯一的超级管理员，拥有所有的权限
    return true if self.only_super_admin?
    super
  end
    
end
