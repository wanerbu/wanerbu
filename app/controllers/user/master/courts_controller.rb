# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::CourtsController <  User::UserBaseController
  def show
    @court = Court.find(params[:id])
  end

  def new
    @court = Court.new
  end

  def create
    @court = Court.new(params[:court])
    @court.gym_id = current_user.gym.id
    if @court.save
      redirect_to user_master_court_path(@court), notice: I18n.t("activemodel.success.create", model: Court.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Court.model_name.human)
      render :new
    end
  end

  def edit_court_properties_select
    sport_properties = SportProperty.where(:sport_id=>params[:id]) unless params[:id].blank?
    render :partial => "properties",:locals => { :sport_properties => sport_properties }
  end

  def edit
    @court = Court.find(params[:id])
  end

  def update
    @court = Court.find(params[:id])
      if @court.update_attributes(params[:court])
      redirect_to user_master_court_path(@court), notice: I18n.t("activemodel.success.update", model: Court.model_name.human)
      else
        render "edit"
      end
  end

  def destroy
    # TODO Tom 存在性的check
    @court = Court.find(params[:id])
    if @court.destroy
        render "new"
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Court.model_name.human)
      render :show
    end
  end

end
