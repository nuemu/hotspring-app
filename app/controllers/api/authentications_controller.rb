class Api::AuthenticationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = login(params[:name], params[:password])
    render json: user
  end
end
