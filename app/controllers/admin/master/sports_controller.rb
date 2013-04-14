class Admin::Master::SportsController < Admin::AdminBaseController
# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
  def show
    @sport = Sport.find(params[:id])
  end
  def new
    @sport = Sport.new
  end
  def create
    @sport = Sport.new(params[:sport])
    @sport.attributes = {'property_ids' => []}.merge(params[:sport] || {})
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
    @sport.attributes = {'property_ids' => []}.merge(params[:sport] || {})
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
