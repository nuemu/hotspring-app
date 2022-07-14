class Api::UsersController < Api::BaseController
  def show
    user = User
      .includes(posts: :hotspring)
      .with_attached_avatar
      .find_by(name: params[:id])
    render json: UserSerializer.new(user, { include: [:posts] })
  end

  def update
    user = User.find_by(name: params[:id])
    user.update(user_params)
    user.avatar.attach(params[:avatar]) if params[:avatar]
    render json: UserSerializer.new(user, { include: [:posts] })
  end

  def destroy
    user = User.find_by(name: params[:id])
    user.destroy
    render json: 'Success'
  end

  private

  def user_params
    params.permit(:name, :avatar, :introduce)
  end
end
