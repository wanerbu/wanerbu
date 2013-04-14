class Admin::Master::PropertiesController < Admin::AdminBaseController
# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
  def show
    @property = Property.find(params[:id])
  end
  def new
    @property = Property.new
  end
  def create
    @property = Property.new(params[:property])
    if @property.save
      redirect_to admin_master_property_path(@property), notice: I18n.t("activemodel.success.create", model: Property.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Property.model_name.human)
      render :new
    end
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    # TODO Tom 存在性的check
    if @property.update_attributes(params[:property])
      redirect_to admin_master_property_path(@property), notice: I18n.t("activemodel.success.update", model: Property.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.update", model: Property.model_name.human)
      render :edit
    end
  end
  def destroy
    @property = Property.find(params[:id])
    # TODO Tom  存在性的check

    if @property.destroy
      redirect_to new_admin_master_property_path, notice: I18n.t("activemodel.success.destroy", model: Property.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Property.model_name.human)
      render :show
    end
  end
end
