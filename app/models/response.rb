class Response < ActiveRecord::Base
	belongs_to :poll
	
	validates_uniqueness_of :identifier, :scope => :poll_id, :on => :create, :unless => :allow_multiple?
	validate :verify_value, :verify_value_with_poll, :poll_receives_votes
	
	protected
	
	def allow_multiple?
		self.poll.multiple
	end
	
	def poll_receives_votes
		errors.add(:base, "Poll does not recieve votes") if poll.receives_votes == false
	end
	
	def verify_value
		if value != "A" and value != "B" and value != "C" and value != "D"
			errors.add(:value, "Answer can only be A, B, C or D")
		end
	end
	
	def verify_value_with_poll
		if poll.n_options == 2
			if( value != "A" and value != "B" )
				errors.add(:value, "Poll only alows A and B")
			end
		end
		
		if poll.n_options == 3
			if( value != "A" and value != "B" and value != "C" )
				errors.add(:value, "Poll only alows A, B and C")
			end
		end
		
	end
	
end
