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

  def create_duplicate

    @challenge = Challenge.find(params[:id])
    @workout = current_user.workouts.new

    if @workout.save

      WoSet.where(:challenge_id => @challenge).each do |challenge_woset|
        @workout_woset = challenge_woset.dup
        @workout_woset.workout_id = @workout.id
        @workout_woset.challenge_id = nil
        @workout_woset.save
      end
    
      redirect_to root_path
    else
      redirect_to :back
    end
    @post = current_user.posts.build
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
    WoSet.where(:challenge_id => @challenge.id).each do |i|
      i.destroy
    end
    @challenge.destroy
    redirect_to challenges_path
  end

  private
    def challenge_params
      params.require(:challenge).permit(:user_id, :content, wo_sets_attributes:[:id, :exercise_id, :rep, :weight, :time, :distance])
    end
end
