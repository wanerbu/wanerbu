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
  def search
    if params[:type] == "gym"
      @gyms = Gym.where("area_id" => params[:id])
      render :partial => "gyms_select"
    end
    if params[:type] == "court"
      @gym = Gym.find(params[:id])
      @courts =@gym.courts
      render :partial => "courts_select"
    end
  end
  def get_cities_by_province_id
    cities = City.where(:province_id=>params[:province_id]) unless params[:province_id].blank?
    render :partial => "cities",:locals => { :cities => cities }
  end
  def get_areas_by_city_id
    areas = Area.where(:city_id=>params[:city_id]) unless params[:city_id].blank?
    render :partial => "areas",:locals => { :areas => areas }
  end
end
