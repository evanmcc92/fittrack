class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @post = current_user.posts.build
    @posts = @user.posts
    @workouts = @user.workouts
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

    @user = User.find(params[:id])
    @users = @user.followed_users

    render 'show_follow'

    @post = current_user.posts.build
    @posts = @user.posts
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers

    render 'show_follow'
    
    @post = current_user.posts.build
    @posts = @user.posts
  end
end
