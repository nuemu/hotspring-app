class Api::SessionsController < Api::BaseController
  skip_before_action :authenticate, only: [:create]

  def create
    user = login(params[:name], params[:password])
    if user
      token = encode(user.id)
      response.header['authtoken'] = token
      user_json = UserSerializer.new(user, { include: [:favorites] })
      render json: user_json
    else
      render json: 'login_failed', status: :not_found
    end
  end

  def me
    user_json = UserSerializer.new(current_user, { include: [:favorites] })
    render json: user_json
  end
end
