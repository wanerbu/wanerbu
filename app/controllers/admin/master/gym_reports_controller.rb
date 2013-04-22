# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class Admin::Master::GymReportsController < Admin::AdminBaseController
  def index
    @gym_report = GymReport.new(params[:gym_report])
    @gym_report.assets.per_page = 10
    @assets = @gym_report.assets.page(params[:page])
  end
end
