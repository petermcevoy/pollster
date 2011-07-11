class AddAmnimationFlagToPoll < ActiveRecord::Migration
  def change
		add_column :polls, :animation, :boolean, :default => true
  end
end
