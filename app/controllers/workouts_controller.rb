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
    @wo_set = WoSet.find_by(params[:id])

    if @workout.update_attributes(workout_params)
      #if task saves
      flash[:success] = "workout Updated"
      redirect_to @workout
    else
      #if task doesnt save
      flash[:error] = "workout not Updated"
      redirect_to root_path
    end
  end

  def destroy
    @workout = Workout.find_by(params[:model_id])
    @feed_item = Feed.find(params[:id])
    @workout.destroy
    @feed_item.destroy

    redirect_to workouts_path
  end

  private
    def workout_params
      params.require(:workout).permit(:user_id, wo_sets_attributes:[:id, :exercise_id, :rep, :weight, :time, :distance])
    end
end
