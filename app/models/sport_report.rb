# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
# 属性Report
#
class SportReport
  include Datagrid

  scope do
    Sport
  end

  filter(:name, :string)

  column(:name)
  column(:intro)
  column(:sort)
  column(:actions, :html => true) { |asset| render :partial => "admin/master/sport_reports/actions", :locals => {:target => asset} }
end
