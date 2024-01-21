class DashboardController < ApplicationController
  def index
    if params[:q]
      @deputies = Parliamentary.where('tx_nome_parlamentar ILIKE ?', "%#{params[:q]}%")
      if params[:q].empty? || @deputies.empty?
        redirect_to root_path,
                    alert: 'Não foi possível encontrar o candidato solicitado'
      end
    else
      @deputies = Parliamentary.all
    end
  end

  def show
    @parliamentary = Parliamentary.find(params[:id])
  end
end
