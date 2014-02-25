class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.all
  end

  def show
    @workout = Workout.find(params[:id])
  end

  def new
    @workout = Workout.new
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

    redirect_to :back
  end

  private
    def workout_params
      params.require(:workout).permit(:user_id, :wo_set_ids, :wo_set.exercise_id, :wo_set.rep, :wo_set.weight, :wo_set.time, :wo_set.distance)
    end
end
