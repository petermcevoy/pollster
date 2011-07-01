class AddOptionsFieldToEvents < ActiveRecord::Migration
  def change
		add_column :events, :options, :text
  end
end
