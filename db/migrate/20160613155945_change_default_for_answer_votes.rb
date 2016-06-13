class ChangeDefaultForAnswerVotes < ActiveRecord::Migration
  def change
    change_column :votes, :num_votes, :integer, default: 1
  end
end
