class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def destroy
    @feed_item = Feed.find(params[:id])
  	@post = Post.find_by(params[:model_id])
    @feed_item.destroy
    @post.destroy
    redirect_to :back
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
end
