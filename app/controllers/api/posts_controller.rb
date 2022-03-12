class Api::PostsController < Api::BaseController
  def create
    comments = current_user.post(post_params)
    render json: comments[-1]
  end

  private

  def post_params
    params.permit(:id, :comment)
  end
end
