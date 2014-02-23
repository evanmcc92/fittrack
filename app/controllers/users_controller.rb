class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @post = current_user.posts.build
    @posts = @user.posts
  end

  def index
  	if params[:search]
      @user = User.search(params[:search])
    else
      @users = User.all
    end
  end
end
