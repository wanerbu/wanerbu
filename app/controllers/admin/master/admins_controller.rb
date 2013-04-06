# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class Admin::Master::AdminsController < Admin::AdminBaseController

  def show
    @admin = Admin.find(params[:id])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      flash[:notice] = 'save success'
      redirect_to admin_master_admin_path(@admin)
    else
      flash[:alert] = 'save fail!'
      render :new
    end
  end

  def edit
  end

  def update
  end

end
