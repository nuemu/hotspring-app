class Api::SessionsController < Api::BaseController
  skip_before_action :authenticate, only: [:create]

  def create
    user = login(params[:name], params[:password])
    if user
      token = encode(user.id)
      response.header['authtoken'] = token
      render json: user.name
    else
      render json: 'login_failed', status: :not_found
    end
  end

  def me
    render json: current_user.name
  end
end
