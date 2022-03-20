class Api::FavoritesController < Api::BaseController
  def create
    favorite =
      Hotspring
      .find(params[:hotspring_id])
      .favorites << Favorite.new(user_id: current_user.id)
    render json: favorite
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    render json: favorite
  end
end
