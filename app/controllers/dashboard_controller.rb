# frozen_string_literal: true

# DashboardController
class DashboardController < ApplicationController
  def index
    if params[:q]
      @parliamentarians = Parliamentary.where('tx_nome_parlamentar ILIKE ?', "%#{params[:q]}%")
      if params[:q].empty? || @parliamentarians.empty?
        redirect_to root_path,
                    alert: 'Não foi possível encontrar o candidato solicitado'
      end
    else
      @parliamentarians = Parliamentary.all
    end
  end

  def show
    @parliamentary = Parliamentary.find(params[:id])
  end
end
