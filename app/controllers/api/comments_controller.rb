class Api::CommentsController < Api::BaseController
  def create
    comments = current_user.post(post_params)
    comment = CommentSerializer.new(comments[-1])
    render json: comment
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.delete
    render json: comment
  end

  private

  def post_params
    params.permit(:hotspring_id, :comment)
  end
end
