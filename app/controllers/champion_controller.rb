class ChampionController < ApplicationController
  def index
    @data = Champion.all
    render json: @data.to_json
  end

  def urf_win_loss
    @data = Urf::ChampionWinLoss.all
    render json: @data.to_json
  end
end
