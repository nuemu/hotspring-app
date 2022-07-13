class Api::MountainsController < Api::BaseController
  def index
    mountain_ids = Spot.group(:mountain_id).count
    mountains = Mountain.includes(:spots).with_attached_image.where(id: mountain_ids.keys)
    render json: MountainSerializer.new(mountains)
  end

  def show
    spots = Spot.includes(:hotspring).where(mountain_id: params[:id])
    render json: SpotSerializer.new(spots)
  end
end
