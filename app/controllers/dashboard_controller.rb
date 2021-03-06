class DashboardController < ApplicationController
  def index
    if params[:q]
      @deputies = Deputy.where("tx_nome_parlamentar ILIKE ?", "%#{params[:q]}%")
      redirect_to root_path, alert: "Não foi possível encontrar o candidato solicitado" if params[:q].empty? || @deputies.empty?
    else
      @deputies = Deputy.all
    end
  end

  def show
    @deputy = Deputy.find(params[:id])
  end

end
