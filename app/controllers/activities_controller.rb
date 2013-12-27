class ActivitiesController < ApplicationController
  def activity_home
  end
  def new
    @activity = Activity.new
  end
  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      redirect_to activity_path(@activity), notice: I18n.t("activemodel.success.create", model: Activity.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Activity.model_name.human)
      render :new
    end
  end
end
