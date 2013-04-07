# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class User::Master::GymReportsController < User::UserBaseController
  def index
    @gym_report = GymReport.new(params[:gym_report])
    @gym_report.assets.per_page = 1
    @assets = @gym_report.assets.page(params[:page])
  end
end
