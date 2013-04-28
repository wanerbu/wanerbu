# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::GamesController <  User::UserBaseController
  def show
    @game= Game.find(params[:id])
  end

  def new
    @game= Game.new
  end

  def create
    @game= Game.new(params[:game])
    @game.court_id = Court.where(:sport_id => params[:sport_id]).first.id
    if @game.save
      redirect_to user_master_game_path(@game), notice: I18n.t("activemodel.success.create", model: Game.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Game.model_name.human)
      render :new
    end
  end


  def edit
    @game= Game.find(params[:id])
  end

  def update
    @game= Game.find(params[:id])
      if @game.update_attributes(params[:game])
      redirect_to user_master_game_path(@game), notice: I18n.t("activemodel.success.update", model: Game.model_name.human)
      else
        render "edit"
      end
  end

  def destroy
    # TODO Tom 存在性的check
    @game= Game.find(params[:id])
    if @game.destroy
        render "new"
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Game.model_name.human)
      render :show
    end
  end

end
