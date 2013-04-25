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
  # TODO dairg 这里如果不注释掉，那么在新建用户并指定角色时，验证会失败
  # validates_presence_of(:admin_id)
  # validates_presence_of(:role_id)

  ### Relations
  belongs_to(:admin)
  belongs_to(:role)
end
