# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
class Admin::Master::SportsController < Admin::AdminBaseController
  # 对于每一个action进行权限检查
  load_and_authorize_resource 
  def show
    @sport = Sport.find(params[:id])
  end
  def new
    @sport = Sport.new
  end
  def create
    @sport = Sport.new(params[:sport])
    if @sport.save
      redirect_to admin_master_sport_path(@sport), notice: I18n.t("activemodel.success.create", model: Sport.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Sport.model_name.human)
      render :new
    end
  end

  def edit
    @sport = Sport.find(params[:id])
  end

  def update
    @sport = Sport.find(params[:id])
    if params[:sport][:sport_properties_attributes].present?
      params[:sport][:sport_properties_attributes].each do |p|
        p[:_destroy] = true if p[:property_id].blank?
      end
    end
    # TODO Tom 存在性的check
    if @sport.update_attributes(params[:sport])
      redirect_to admin_master_sport_path(@sport), notice: I18n.t("activemodel.success.update", model: Sport.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.update", model: Sport.model_name.human)
      render :edit
    end
  end
  def destroy
    @sport = Sport.find(params[:id])
    # TODO Tom  存在性的check

    if @sport.destroy
      redirect_to new_admin_master_sport_path, notice: I18n.t("activemodel.success.destroy", model: Sport.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Sport.model_name.human)
      render :show
    end
  end
end
