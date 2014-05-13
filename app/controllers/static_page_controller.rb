class StaticPageController < ApplicationController
	
  def index
    if signed_in?
		@feed_items = current_user.feed.paginate(:page => params[:page])
		@workout = Workout.find_by(params[:model_id])
		@post = current_user.posts.build
		
	end
  end
end
