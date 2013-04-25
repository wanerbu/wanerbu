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
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :encryptable,  :lockable, :timeoutable, :authentication_keys => [:login]
         # TODO dairg 是否确认配置
         # :confirmable,
         # :registerable,

  # 逻辑删除
  acts_as_paranoid

  ### 常量
  SUPER_ADMIN_ID = 1

  # Virtual attribute for authenticating by either login_id or email
  attr_accessor :login 
 
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
                  :password,
                  :remember_me,
                  :password_salt,
                  :login_id,
                  :login,
                  :first_name,
                  :last_name,
                  :telephone_no,
                  :status,
                  :role_ids
 
  ### validations
  # validates :login_id, :password_confirmation,  :presence => true, on: :create
  validates :login_id, :presence => true, on: :create
  validates :login_id, :length => { :in => 6..16 }, if: "login_id.present?", on: :create
  validates :login_id, :format => { if: "login_id.present?", with: Wanerbu::Common::FORMAT_LOGIN_ID }, on: :create
  validates :first_name, :last_name, :length => { :in => 0..10 }
  validates :telephone_no, :length => { :in => 0..15 }
  validates :telephone_no, :format => { if: "telephone_no.present?", with: Wanerbu::Common::FORMAT_TELEPHONE}

  before_validation do 
    # TODO dairg define the code 
    self.password = Devise.friendly_token.first(Wanerbu::Common::AUTO_GENERATE_PASSWORD_LENGTH) if self.new_record? && self.password.blank?
  end

  # validates :status, :format => { if: "status.present?", with: Wanerbu::Common::FORMAT_TELEPHONE}
  enumerize :status, in: Wanerbu::CodeDefine::ADMIN_STATUS, default: :active

  ### Relations
  has_many(:admin_roles, :validate => :false)
  has_many(:roles, through: :admin_roles, :validate => :false)

  ### DefaultScope
  default_scope order("login_id ASC")

  ### Scopes
  scope :except_super_admin, where('id <> ?', SUPER_ADMIN_ID)
 
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

  # 覆盖devise的这个方法，可以修改认证登录的条件
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      # TODO dairg 大小写问题的确认
      where(conditions).where(["lower(login_id) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
end
