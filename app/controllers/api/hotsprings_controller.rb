class Api::HotspringsController < Api::BaseController
  def index
    hotsprings = Hotspring.all
    render json: hotsprings
  end

  def show
    hotspring = Hotspring
                .includes(:posts, articles: :user, comments: :user)
                .find_nearby(params[:lat].to_f, params[:lon].to_f, GAP)
    hotspring_json = HotspringSerializer.new(hotspring, { include: [:posts, :articles, :comments] })
    render json: hotspring_json
  end

  def create
    hotspring = Hotspring.new(hotspring_params)
    hotspring.save
    render json: hotspring
  end

  def update
    hotspring = Hotspring.find(params[:id])
    params[:image] ? hotspring.image.attach(params[:image]) : hotspring.update(hotspring_params)
    render json: hotspring
  end

  private

  def hotspring_params
    params.permit(:name, :status, :latitude, :longtitude, :description, :image)
  end
end
