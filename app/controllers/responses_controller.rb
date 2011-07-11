class ResponsesController < ApplicationController
	
	before_filter :get_event
	
	def button
		@poll = @event.polls.last
		render :layout => false
	end
	
	def vote
		#get poll id from self do not rely on client info
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
			render :action => "vote", :format => :js
		else
			render :text => "fail"
		end
		
	end
	
	private
	
	def get_event
		#gets event either from subdomain or id param (id param if not using subdomain)
		if !request.subdomain.empty?
			@event = Event.find_by_name(request.subdomain)
		else
			 @event = Event.find_by_id(params[:id])
		end
	end
	
end
