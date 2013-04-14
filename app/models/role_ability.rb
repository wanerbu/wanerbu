# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 角色权限模块
#
# TODO dairg 将来这个文件要移到 lib/wanerbu/common 目录下
module Wanerbu::Common::RoleAbility

  def ability?(function)
    @available_functions ||= self.roles.map { |f| f.functions }.flatten
    @available_functions.include?(function)
  end

end
