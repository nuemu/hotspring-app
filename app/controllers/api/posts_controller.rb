class Api::PostsController < Api::BaseController
  def create
    posts = current_user.posts << Post.new(post_params)
    render json: posts[-1]
  end

  def update
    post = current_user.posts.find(params[:id])
    post.update(post_params)

    render json: post
  end

  private

  def post_params
    params.permit(:id, :hotspring_id, :status)
  end
end
