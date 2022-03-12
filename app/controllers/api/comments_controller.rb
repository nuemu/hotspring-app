class Api::CommentsController < Api::BaseController
  def create
    comments = current_user.post(post_params)
    render json: comments[-1]
  end

  private

  def post_params
    params.permit(:hotspring_id, :comment)
  end
end
