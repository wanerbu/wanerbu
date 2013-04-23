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
  
  # Virtual attribute for authenticating by either login_id or email
  attr_accessor :login 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :password_salt,
                  :login
  # attr_accessible :title, :body

  #添加association
  has_one :gym

  before_save do
    # TODO dairg 临时的处理
    self.login_id = self.email
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
