class Api::SessionsController < Api::BaseController
  def create
    user = login(params[:name], params[:password])
    if user
      token = encode(user.id)
      response.header['authtoken'] = token
      user_json = UserSerializer.new(user, { include: [:favorites] })
      render json: user_json
    else
      render json: 'failed'
    end
  end

  def me
    user = User.includes(:favorites, :posts).find(current_user.id)
    user_json = UserSerializer.new(user, { include: [:favorites, :posts] })
    render json: user_json
  end

  def csrf
    render json: 'session'
  end
end
