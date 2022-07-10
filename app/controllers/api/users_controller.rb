class Api::UsersController < Api::BaseController
  def show
    user = User
      .includes(posts: :hotspring)
      .find_by(name: params[:id])
    render json: UserSerializer.new(user, { include: [:posts] })
  end
end
