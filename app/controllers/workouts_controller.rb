class WorkoutsController < ApplicationController
  def index
    @feed_items = current_user.recent_feeds.paginate(:page => params[:page])
    @post = current_user.posts.build
    @workout = Workout.find_by(params[:model_id])
  end

  def show
    @workout = Workout.find(params[:id])
    @post = current_user.posts.build
  end

  def new
    @workout = Workout.new
    @workout.wo_sets.build
    @post = current_user.posts.build
  end

  def edit
    @workout = Workout.find(params[:id])
    @wo_set = WoSet.find_by(params[:workout_id])
    @post = current_user.posts.build
  end

  def create
    @workout = current_user.workouts.build(workout_params)

    if @workout.save
      redirect_to @workout
    else
      redirect_to root_path
    end
  end

  def update
    @workout = Workout.find(params[:id])
    @wo_set = WoSet.find_by(params[:workout_id])


    if @workout.update_attributes(workout_params)
      #if workout saves
      flash[:success] = "workout Updated"
      redirect_to @workout
    else
      #if workout doesnt save
      flash[:error] = "workout not Updated"
      redirect_to root_path
    end
  end

  def destroy
    @feed_item = Feed.find(params[:id])
    @workout = Workout.find_by(@feed_item.model_id)
    WoSet.where(:workout_id => @feed_item.model_id).each do |i|
      i.destroy
    end
    @workout.destroy
    @feed_item.destroy

    redirect_to :back
  end

  private
    def workout_params
      params.require(:workout).permit(:user_id, wo_sets_attributes:[:id, :exercise_id, :rep, :weight, :time, :distance])
    end
end
