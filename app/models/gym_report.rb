# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 系统管理员Report
#
class GymReport
  include Datagrid

  scope do
    Gym
  end

  filter(:name, :string)
  column(:name)
  column(:created_at)
  column(:actions, :html => true) { |asset| render :partial => "user/master/gym_reports/actions", :locals => {:target => asset} }
end

