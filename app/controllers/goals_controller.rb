class GoalsController < ApplicationController
	def create
		@goal = current_user.goals.create(goal_params)

		if @goal.save
			redirect_to :back
		else
			redirect_to user_path(current_user)
		end
	end

	def destroy
	    @goal = Goal.find(params[:id])
	    @goal.destroy
	    redirect_to :back
	end

	private
		def goal_params
  			params.require(:goal).permit(:exercise_id, :weight, :distance, :time)
  		end
end
