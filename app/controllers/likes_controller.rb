class LikesController < ApplicationController
    def create
      target = Feed.find(params[:resource_id])
      current_user.likes(target)
      redirect_to :back, :notice => 'success'
    end

    def destroy
      target = Feed.find(params[:resource_id])
      current_user.dislikes(target)
      redirect_to :back, :notice => 'success'
    end
end
