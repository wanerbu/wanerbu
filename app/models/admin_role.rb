# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 管理员角色关系表
#
class AdminRole < ActiveRecord::Base
  ### Validations
  validates_presence_of(:admin_id)
  validates_presence_of(:role_id)

  ### Relations
  belongs_to(:admin)
  belongs_to(:role)
end
