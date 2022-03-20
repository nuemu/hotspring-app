class Api::HotspringsController < Api::BaseController
  skip_before_action :authenticate, only: %w[index show]

  def index
    hotsprings = Hotspring.permit(params[:status].to_i)
    render json: hotsprings
  end

  def show
    hotspring = Hotspring
                .includes(:comments, :posts, :articles, comments: :user)
                .find_by(latitude: params[:lat], longtitude: params[:lon])
    hotspring_json = HotspringSerializer.new(hotspring, { include: [:comments, :posts, :articles] })
    render json: hotspring_json
  end

  def create
    hotspring = Hotspring.new(hotspring_params)
    hotspring.save
    render json: hotspring
  end

  def update
    hotspring = Hotspring.find_by(latitude: params[:lat], longtitude: params[:lon])
    hotspring.update(hotspring_params)
    render json: hotspring
  end

  private

  def hotspring_params
    params.permit(:name, :status, :latitude, :longtitude, :description)
  end
end
