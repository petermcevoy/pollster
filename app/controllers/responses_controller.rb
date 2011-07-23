class ResponsesController < ApplicationController
	
	before_filter :get_event
	
	def button
		@poll = @event.polls.last
		render :layout => false
	end
	
	def vote
		@poll = @event.polls.last
		
		#check if already voted
		if @poll.responses.find_by_identifier(session[:session_id]) and @poll.multiple == false
			@response = @poll.responses.find_by_identifier(session[:session_id])
			@response.value = params[:value]
			logger.info("edit")
		else
			@response = @poll.responses.new(:value => params[:value], :identifier => session[:session_id])
		end
		
		if @response.save
			broadcast "/vote/#{@event.id}/#{@poll.id}", {:value => @response.value.downcase, :id => @response.identifier, :multiple => @poll.multiple}
			if params[:ajax] == "1"
				render :text => "OK"
			else
				redirect_to "#{@event.name}.lvh.me:3000"
			end
		else
			render :text => "fail"
		end
		
	end
	
	private
	
	def get_event
		#POLLSTER_ENV is set in environment.rb
		# gets event id either from url or from subdomain, if there is a subdomain specified (and env is global)
		if !request.subdomain.empty? and POLLSTER_ENV == 'global'
			@event = Event.find_by_name(request.subdomain(TLD_SIZE))
			logger.info(request.subdomain(TLD_SIZE))
			logger.info("sub")
			logger.info(TLD_SIZE)
		else
			 @event = Event.find_by_id(params[:event_id])
			logger.info("no-sub")
		end
	end
	
end
