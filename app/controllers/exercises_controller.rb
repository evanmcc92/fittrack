class ExercisesController < ApplicationController

  def create
  	@exercise = current_user.exercises.create(exercise_params)

  	if @exercise.save
  		redirect_to exercises_path
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
    @post = current_user.posts.build
  end

  def edit
    @exercise = Exercise.find(params[:id])
    @post = current_user.posts.build
  end


  def update
    @exercise = Exercise.find(params[:id])

    if @exercise.update_attributes(exercise_params)
      #if task saves
      flash[:success] = "exercise Updated"
      redirect_to :back
    else
      #if task doesnt save
      flash[:error] = "exercise not Updated"
      redirect_to root_path
    end
  end

  def index
  	@exercises = Exercise.all
    @post = current_user.posts.build
  end

  def import
    Exercise.import(params[:file], params[:user_id])
    redirect_to :back, notice: "Exercises imported."
  end

  private

  	def exercise_params
  		params.require(:exercise).permit(:name, :description, :category)
  	end
end
