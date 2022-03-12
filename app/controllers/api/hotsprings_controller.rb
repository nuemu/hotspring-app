class Api::HotspringsController < Api::BaseController
  skip_before_action :authenticate

  def index
    hotsprings = Hotspring.permit(params[:status].to_i)
    render json: hotsprings
  end

  def show
    hotspring = Hotspring.find_by(name: params[:name])
    hotspring_json = HotspringSerializer.new(hotspring)
    render json: hotspring_json
  end
end
