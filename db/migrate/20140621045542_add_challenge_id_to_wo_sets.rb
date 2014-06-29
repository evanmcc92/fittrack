class AddChallengeIdToWoSets < ActiveRecord::Migration
  def change
    add_reference :wo_sets, :challenge, index: true
  end
end
