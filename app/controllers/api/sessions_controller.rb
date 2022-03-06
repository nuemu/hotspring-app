class Api::SessionsController < Api::BaseController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate

  def create
    user = login(params[:name], params[:password])
    render json: user.name
  end
end
