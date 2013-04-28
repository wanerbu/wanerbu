# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
# 场地Report
#
class CourtReport
  include Datagrid

  scope do
    Court
  end
#TODO 这里需要按项目名查找
  filter(:id, :string)

#TODO 这里需要显示项目名，项目属性等关联属性
  column(:id)
  column(:actions, :html => true) { |asset| render :partial => "user/master/court_reports/actions", :locals => {:target => asset} }
end
