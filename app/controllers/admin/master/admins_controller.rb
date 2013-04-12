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
      redirect_to admin_master_admin_path(@admin), notice: I18n.t("activemodel.success.create", model: Admin.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Admin.model_name.human)
      render :new
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  # 
  def update
    @admin = Admin.find(params[:id])
    # TODO dairg 存在性的check
    if @admin.update_attributes(params[:admin])
      redirect_to admin_master_admin_path(@admin), notice: I18n.t("activemodel.success.update", model: Admin.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.update", model: Admin.model_name.human)
      render :edit
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    # TODO dairg 存在性的check

    if @admin.destroy
      redirect_to admin_master_admin_reports_path, notice: I18n.t("activemodel.success.destroy", model: Admin.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Admin.model_name.human)
      render :show
    end
  end
end
