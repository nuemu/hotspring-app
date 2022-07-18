class Api::CommentsController < Api::BaseController
  def create
    comments = current_user.comments << Comment.new(comment_params)
    comment = CommentSerializer.new(comments[-1])
    current_user.level_up
    render json: comment
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy
    render json: comment
  end

  private

  def comment_params
    params.permit(:hotspring_id, :comment)
  end
end
