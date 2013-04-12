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
         :token_authenticatable, :encryptable,:lockable, :timeoutable
         #TODO Tom 暂时取消注册确认邮件功能 
         #:confirmable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :password_salt
  # attr_accessible :title, :body

  #添加association
  has_one :gym

  before_save do
    # TODO dairg 临时的处理
    self.login_id = self.email
  end
end
