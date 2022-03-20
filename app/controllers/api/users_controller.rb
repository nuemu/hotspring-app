class Api::UsersController < Api::BaseController
  # SECURITY !!!
  def index
    render json: User.all
  end
end
