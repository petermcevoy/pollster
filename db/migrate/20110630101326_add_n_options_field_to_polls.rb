class AddNOptionsFieldToPolls < ActiveRecord::Migration
  def change
		add_column :polls, :n_options, :integer
  end
end
