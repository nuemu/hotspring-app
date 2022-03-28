class Api::CommentsController < Api::BaseController
  def create
    comments = current_user.comments << Comment.new(hotspring_id: comment_params[:hotspring_id], comment: comment_params[:comment])
    comment = CommentSerializer.new(comments[-1])
    render json: comment
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.delete
    render json: comment
  end

  private

  def comment_params
    params.permit(:hotspring_id, :comment)
  end
end
