# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::GamesController <  User::UserBaseController
  # 对于每一个action进行权限检查
  load_and_authorize_resource 
  skip_authorize_resource :only => [:new,:create] 
  def show
    @game= Game.find(params[:id])
  end

  def new
    @game= Game.new
  end

  def create
    @game= Game.new(params[:game])
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
  def new_price_rule
    @game_price_rule= GamePriceRule.new(params[:price_rule])
    if @game_price_rule.save
      redirect_to user_master_game_path(@game), notice: I18n.t("activemodel.success.create", model: GamePriceRule.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: GamePriceRule.model_name.human)
      redirect_to user_master_game_path(@game)
    end
  end
  
  def delete_game_price_rule
    @price_rule = GamePriceRule.find(params[:price_rule_id])
    @game= Game.find(@price_rule.game_id)
    if @price_rule.destroy
      redirect_to user_master_game_path(@game), notice: I18n.t("activemodel.success.destroy", model: GamePriceRule.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: GamePriceRule.model_name.human)
      redirect_to user_master_game_path(@game)
    end
  end

  def new_reservation_rule
    @game_reservation_rule= GameReservationRule.new(params[:reservation_rule])
    if @game_reservation_rule.save
      redirect_to user_master_game_path(@game), notice: I18n.t("activemodel.success.create", model: GameReservationRule.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: GameReservationRule.model_name.human)
      redirect_to user_master_game_path(@game)
    end
  end
  
  def delete_game_reservation_rule
    @reservation_rule = GameReservationRule.find(params[:reservation_rule_id])
    @game= Game.find(@reservation_rule.game_id)
    if @reservation_rule.destroy
      redirect_to user_master_game_path(@game), notice: I18n.t("activemodel.success.destroy", model: GameReservationRule.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: GameReservationRule.model_name.human)
      redirect_to user_master_game_path(@game)
    end
  end

end
