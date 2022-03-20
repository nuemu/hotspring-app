class Api::RegistersController < Api::BaseController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate

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
    params.permit(:name, :password)
  end
end
