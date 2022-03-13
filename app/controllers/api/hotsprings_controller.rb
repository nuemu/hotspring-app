class Api::HotspringsController < Api::BaseController
  skip_before_action :authenticate, only: %w[index show]

  def index
    hotsprings = Hotspring.permit(params[:status].to_i)
    render json: hotsprings
  end

  def show
    hotspring = Hotspring.find_by(name: params[:id])
    hotspring_json = HotspringSerializer.new(hotspring)
    render json: hotspring_json
  end

  def create
    hotspring = Hotspring.new(hotspring_params)
    hotspring.save
    render json: hotspring
  end

  private

  def hotspring_params
    params.permit(:latitude, :longtitude, :description)
  end
end
