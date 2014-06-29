class WoSetsController < ApplicationController
  def destroy
    @wo_set = WoSet.find(params[:id])
    @wo_set.destroy

    redirect_to :back
  end
end
