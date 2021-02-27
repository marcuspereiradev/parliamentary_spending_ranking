class DashboardController < ApplicationController
  def index
    @deputies = Deputy.all
  end
end
