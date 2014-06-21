class ChallengesController < ApplicationController
  def new
    @post = current_user.posts.build
    @challenge = Challenge.new
    @challenge.wo_sets.build
  end

  def create
    @post = current_user.posts.build
    @challenge = current_user.challenges.build(challenge_params)

    if @challenge.save
      redirect_to @challenge
    else
      redirect_to root_path
    end
  end

  def index
    @post = current_user.posts.build
    @challenges = Challenge.all
  end

  def show
    @post = current_user.posts.build
    @challenge = Challenge.find(params[:id])
  end

  def edit
    @challenge = Challenge.find(params[:id])
    @wo_set = WoSet.find_by_challenge_id(params[:challenge_id])
    @post = current_user.posts.build
  end

  def update
    @post = current_user.posts.build
    @challenge = Challenge.find(params[:id])
    @wo_set = WoSet.find_by(params[:challenge_id])


    if @challenge.update_attributes(challenge_params)
      #if task saves
      flash[:success] = "challenge Updated"
      redirect_to @challenge
    else
      #if task doesnt save
      flash[:error] = "challenge not Updated"
      redirect_to root_path
    end
  end

  def destroy
    @challenge = Challenge.find(params[:id])
    WoSet.find_by(:challenge_id => @challenge.id).destroy
    @challenge.destroy
    redirect_to challenges_path
  end

  private
    def challenge_params
      params.require(:challenge).permit(:user_id, :content, wo_sets_attributes:[:id, :exercise_id, :rep, :weight, :time, :distance])
    end
end
