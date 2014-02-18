class WorkoutsController < ApplicationController
  def new
    @workout = Workout.new
  end

  def create
    @workout = current_user.workouts.create(workout_params)

    if @workout.save
      redirect_to workouts_path
    else
      redirect_to root_path
    end

  end

  def edit
  end

  def show
  end

  def update
  end

  def index
    @workouts = current_user.workouts.all
  end

  private
    def workout_params
      params.require(:workout).permit(:workoutset)
    end

end
