# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::CourtsController <  User::UserBaseController
  def new
    @court = Court.new
  end

  def create
    @court = Court.new(params[:court])
    @court.gym_id = current_user.gym.id
    if @court.save
      #根据项目同步更新场地属性表
      sport = Sport.find(params[:court][:sport_id])
      sport.sport_properties.all.each do |sport_property| 
        court_property = CourtProperty.new
        court_property.court_id = @court.id
        court_property.property_id = sport_property.property_id
        court_property.property_value = sport_property.default_value
        court_property.save 
      end
      redirect_to user_master_edit_court_properties_path(@court)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Court.model_name.human)
      render :new
    end
  end

  def edit_court_properties
  end
  def edit

    @gym = Gym.find(params[:id])

  end

  def update

    @gym = Gym.find(params[:id])

      if @gym.update_attributes(params[:gym])
       render "index"
      else
        render "edit"
      end
  end

  def destroy
    # TODO Tom 存在性的check
    @gym = Gym.find(params[:id])
    if @gym.destroy
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.destroy", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Gym.model_name.human)
      render :show
    end
  end
end
