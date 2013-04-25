# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 系统权限
#
class Function

  ### Constants
  FUNCTIONS = {
    # master信息系列
    manage_admin:                   {code: '001', name: '系统用户管理(锁定以外)', abbr_name: '全部(锁定以外)'},
    manage_role:                    {code: '002', name: '角色管理', abbr_name: '全部'},
    manage_user:                    {code: '003', name: '普通用户管理', abbr_name: '全部'},
    lock_admin:                     {code: '004', name: '系统用户锁定', abbr_name: '锁定'}

  }

  FUNCTION_GROUPS = [
    { :title => '系统用户管理', :functions => [:manage_admin, :lock_admin] },
    { :title => '角色管理', :functions => [:manage_role] },
    { :title => '普通用户管理', :functions => [:manage_user] }
  ]

end
