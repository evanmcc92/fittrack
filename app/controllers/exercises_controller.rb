class ExercisesController < ApplicationController
  def create
  	@exercise = current_user.exercises.create(exercise_params)

  	if @exercise.save
  		redirect_to "index"
  	else
  		render root_path
  	end
  end

   def destroy
    @exercise = Exercise.find(params[:id])

    @exercise.destroy

    redirect_to :back
  end

  def new
    @exercise = Exercise.new
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end


  def update
    @exercise = Exercise.find(params[:id])

    if @exercise.update_attributes(update_task_params)
      #if task saves
      flash[:success] = "exercise Updated"
      redirect_to root_path
    else
      #if task doesnt save
      flash[:error] = "exercise not Updated"
      redirect_to :back
    end
  end

  def index
  	@exercises = Exercise.all
  end

  private

  	def exercise_params
  		params.require(:exercise).permit(:name, :description)
  	end
end
