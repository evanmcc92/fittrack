class WorkoutsController < ApplicationController
  def index
    @workouts = current_user.workouts.all
    @post = current_user.posts.build
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
  end

  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy

    redirect_to workouts_path
  end

  private
    def workout_params
      params.require(:workout).permit(:user_id, wo_sets_attributes:[:exercise_id, :rep, :weight, :time, :distance])
    end
end
