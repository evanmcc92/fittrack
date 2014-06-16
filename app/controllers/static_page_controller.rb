class StaticPageController < ApplicationController
	
  def index
    if signed_in?
		@post = current_user.posts.build
		@user = User.find_by(params[:voter_id])
	    
		@feed_items = current_user.feed.paginate(:page => params[:page])
	end
  end
end
