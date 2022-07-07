class Api::RegistersController < Api::BaseController
  def create
    user = User.new(user_params)
    if user.save
      token = encode(user.id)
      response.header['authtoken'] = token
      render json: UserSerializer.new(user)
    else
      render json: 'failed'
    end
  end

  private

  def user_params
    params.permit(:name, :password, :password_confirmation)
  end
end
