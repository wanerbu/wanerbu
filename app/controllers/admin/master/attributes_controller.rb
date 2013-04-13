class Admin::Master::AttributesController < Admin::AdminBaseController
# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
  def show
    @attribute = Attribute.find(params[:id])
  end
  def new
    @attribute = Attribute.new
  end
  def create
    @attribute = Attribute.new(params[:attribute])
    if @attribute.save
      redirect_to admin_master_attribute_path(@attribute), notice: I18n.t("activemodel.success.create", model: Attribute.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Attribute.model_name.human)
      render :new
    end
  end

  def edit
    @attribute = Attribute.find(params[:id])
  end

  def update
    @attribute = Attribute.find(params[:id])
    # TODO Tom 存在性的check
    if @attribute.update_attributes(params[:attribute])
      redirect_to admin_master_attribute_path(@attribute), notice: I18n.t("activemodel.success.update", model: Attribute.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.update", model: Attribute.model_name.human)
      render :edit
    end
  end
  def destroy
    @attribute = Attribute.find(params[:id])
    # TODO Tom  存在性的check

    if @attribute.destroy
      redirect_to new_admin_master_attribute_path, notice: I18n.t("activemodel.success.destroy", model: Attribute.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Attribute.model_name.human)
      render :show
    end
  end
end
