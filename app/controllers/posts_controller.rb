class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to :back
    else
      redirect_to root_url
    end
  end

  def destroy
  	@post = Post.find(params[:id])
  	@post.destroy
    redirect_to :back
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
end
