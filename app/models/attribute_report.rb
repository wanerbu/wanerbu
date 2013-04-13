# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
# 属性Report
#
class AttributeReport
  include Datagrid

  scope do
    Attribute
  end

  filter(:name, :string)

  column(:name)
  column(:unit)
  column(:intro)
  column(:actions, :html => true) { |asset| render :partial => "admin/master/attribute_reports/actions", :locals => {:target => asset} }
end

