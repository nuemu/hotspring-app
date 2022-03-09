class Api::HotspringsController < Api::BaseController
  skip_before_action :authenticate

  def index
    hotsprings = Hotspring.permit(params[:status].to_i)
    render json: hotsprings
  end

  def show
    hotspring = Hotspring.find_by(name: params[:name])
    render json: hotspring, include: [:posts, :comments]
  end
end
