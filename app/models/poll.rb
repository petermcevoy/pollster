class Poll < ActiveRecord::Base
	belongs_to :event
	has_many :responses, :dependent => :destroy
	
	validate :verify_options
	
	protected
	
	def verify_options
		tmp_op = n_options.to_i
		if tmp_op != 2 and tmp_op != 3 and tmp_op != 4
			errors.add(:n_options, "Number of options can only be 2, 3 or 4")
		end
	end
	
end
