# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 普通用户
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :encryptable,:lockable, :timeoutable, :authentication_keys => [:login]
         #TODO Tom 暂时取消注册确认邮件功能 
         #:confirmable
  
  # 逻辑删除
  acts_as_paranoid

  # Virtual attribute for authenticating by either login_id or email
  attr_accessor :login 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :password_salt,
                  :login,
                  :login_id,
                  :first_name,
                  :last_name,
                  :honey_name,
                  :telephone_no,
                  :sex,
                  :birthday,
                  :address,
                  :status

  # attr_accessible :title, :body

  ### validations
  validates :login_id, :password_confirmation,  :presence => true, on: :create
  validates :login_id, :length => { :in => 6..16 }, if: "login_id.present?", on: :create
  validates :login_id, :format => { if: "login_id.present?", with: Wanerbu::Common::FORMAT_LOGIN_ID }, on: :create
  validates :first_name, :last_name, :length => { :in => 0..10 }
  validates :telephone_no, :length => { :in => 0..15 }
  validates :telephone_no, :format => { if: "telephone_no.present?", with: Wanerbu::Common::FORMAT_TELEPHONE}

  #添加association
  has_one :gym

  # 姓名
  def name
    name = ''
    name += self.first_name + ' ' if self.first_name
    name += self.last_name if self.last_name
    return name
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
