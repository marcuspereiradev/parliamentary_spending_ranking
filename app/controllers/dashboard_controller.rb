# frozen_string_literal: true

# DashboardController
class DashboardController < ApplicationController
  def index
    unless params[:q]
      @parliamentarians = Parliamentary.all
      return @parliamentarians
    end

    @parliamentarians = Parliamentary.where('tx_nome_parlamentar ILIKE ?', "%#{params[:q]}%")

    return @parliamentarians if @parliamentarians.present?

    redirect_to root_path, alert: 'Não foi possível encontrar o candidato solicitado'
  end

  def show
    @parliamentary = Parliamentary.find(params[:id])
  end
end
