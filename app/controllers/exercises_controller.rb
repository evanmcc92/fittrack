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
      flash[:success] = "Exercise Updated"
      redirect_to exercises_path
    else
      #if task doesnt save
      flash[:error] = "Exercise not Updated"
      redirect_to root_path
    end
  end

  helper_method :sortcolumn, :sortdirection
  def index
  	@exercises = Exercise.order(sortcolumn + " " + sortdirection)
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

    def sortcolumn
      Exercise.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sortdirection
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
