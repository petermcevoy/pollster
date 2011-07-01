class AddReceivesVotesField < ActiveRecord::Migration
  def change
		add_column :polls, :receives_votes, :boolean, :default => false
  end
end
