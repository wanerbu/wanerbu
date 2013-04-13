class Admin::Master::AttributesController < Admin::AdminBaseController
# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
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
end
