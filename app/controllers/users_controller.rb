class UsersController < ApplicationController
  
  autocomplete :user, :username

  def show
  	@user = User.find_by_username(params[:id])
    @post = current_user.posts.build
    @feed_items = @user.recent_feeds.paginate(:page => params[:page])
    @workout = Workout.find_by(params[:model_id])
  end

  def index
    @post = current_user.posts.build  
  	if params[:search]
      @user = User.search(params[:search]).paginate(:page => params[:page])
    else
      @users = User.all
    end
  end
  
  def following
    @title = "Following"
    @post = current_user.posts.build  

    @user = User.find_by_username(params[:id])
    @users = @user.followed_users.paginate(:page => params[:page])

    render 'show_follow'
    


    if @user.posts.any?
      @posts = @user.posts
    end
  end

  def followers
    @title = "Followers"
    @post = current_user.posts.build
    @user = User.find_by_username(params[:id])
    @users = @user.followers.paginate(:page => params[:page])

    render 'show_follow'
    
    @posts = @user.posts
  end
end
