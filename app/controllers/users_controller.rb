class UsersController < ApplicationController
  def show
  	@user = User.find_by_username(params[:id])
    @post = current_user.posts.build
    @feed_items = @user.recent_feeds
    @workout = Workout.find_by(params[:model_id])
  end

  def index
  	if params[:search]
      @user = User.search(params[:search])
    else
      @users = User.all
    end
  end
  
  def following
    @title = "Following"

    @user = User.find_by_username(params[:id])
    @users = @user.followed_users

    render 'show_follow'

    @post = current_user.posts.build
    if @user.posts. any?
      @posts = @user.posts
    end
  end

  def followers
    @title = "Followers"
    @user = User.find_by_username(params[:id])
    @users = @user.followers

    render 'show_follow'
    
    @post = current_user.posts.build
    @posts = @user.posts
  end
end
