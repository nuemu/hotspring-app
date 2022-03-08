class Api::HotspringsController < Api::BaseController
  skip_before_action :authenticate

  def index
    hotsprings = Hotspring.where(status: params[:status])
    render json: hotsprings
  end

  def show
    hotspring = Hotspring.find_by(name: params[:name])
    render json: hotspring
  end
end
