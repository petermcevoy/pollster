class ResponsesController < ApplicationController
	
	def button
		@poll = Event.find_by_id(params[:id]).polls.last
		render :layout => false
	end
	
	def vote
		#get poll id from self do not rely on client info
		#get event from subdomain
		@event = Event.find_by_id(params[:event_id])
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
	
end
