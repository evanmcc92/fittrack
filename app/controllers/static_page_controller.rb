class StaticPageController < ApplicationController
  def index
    if signed_in?
		@post = current_user.posts.build
		@feed_items = current_user.feed
	end
  end
end
