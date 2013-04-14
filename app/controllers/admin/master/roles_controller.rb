# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class Admin::Master::RolesController < Admin::AdminBaseController

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to admin_master_role_path(@role), notice: I18n.t("activemodel.success.create", model: Role.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Role.model_name.human)
      render :new
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  # 
  def update
    @role = Role.find(params[:id])
    # TODO dairg 存在性的check
    if @role.update_attributes(params[:role])
      redirect_to admin_master_role_path(@role), notice: I18n.t("activemodel.success.update", model: Role.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.update", model: Role.model_name.human)
      render :edit
    end
  end

  def destroy
    @role = Role.find(params[:id])
    # TODO dairg 存在性的check

    if @role.destroy
      redirect_to admin_master_role_reports_path, notice: I18n.t("activemodel.success.destroy", model: Role.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Role.model_name.human)
      render :show
    end
  end
end
