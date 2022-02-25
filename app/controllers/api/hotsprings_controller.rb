class Api::HotspringsController < ApplicationController
  def index
    hotsprings = Hotspring.where(status: params[:status])
    render json: hotsprings
  end
end
