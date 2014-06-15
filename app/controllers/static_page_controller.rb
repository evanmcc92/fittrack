class StaticPageController < ApplicationController
	
  def index
    if signed_in?
		@feed_items = current_user.feed.paginate(:page => params[:page])
		@post = current_user.posts.build
		@user = User.find_by(params[:voter_id])
	end
  end
end
