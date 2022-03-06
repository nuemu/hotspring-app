class Api::HotspringsController < Api::BaseController
  skip_before_action :authenticate
  def index
    hotsprings = Hotspring.where(status: params[:status])
    render json: hotsprings
  end
end
