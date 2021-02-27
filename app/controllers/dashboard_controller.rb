class DashboardController < ApplicationController
  def index
    @deputies = Deputy.all
  end

  def show
    @deputy = Deputy.find(params[:id])
  end

end
