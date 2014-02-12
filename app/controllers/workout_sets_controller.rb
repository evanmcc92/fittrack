class WorkoutSetsController < ApplicationController
  def index
    @workoutsets = WorkoutSets.all
  end

  def new
    @workoutset = WorkoutSet.new
  end

  def show
    @workoutset = WorkoutSet.find(params[:id])
  end

  def edit
    @workoutset = WorkoutSet.find(params[:id])
  end

  def update
    @workoutset = WorkoutSet.find(params[:id])

    if @exercise.update_attributes(exercise_params)
      flash[:success] = "WorkoutSet Updated"
      redirect_to :back
    else
      flash[:error] = "WorkoutSet not Updated"
      redirect_to root_path
    end
  end

  def destroy
    @workoutset = WorkoutSet.find(params[:id])

    @workoutset.destroy

    redirect_to :back
  end

  def create
    @workoutset = current_user.workoutsets.create(workoutset_params)

    if @workoutset.save
      redirect_to workoutsets_path
    else
      render root_path
    end
  end

  private
    def workoutset_params
      params.require(:workoutset).permit(:workout, :exercise, :rep, :weight, :time, :distance)
    end
end
