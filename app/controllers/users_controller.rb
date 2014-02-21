class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def index
  	if params[:search]
      @user = User.search(params[:search])
    else
      @users = User.all
    end
  end
end
