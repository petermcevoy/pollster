class PollsController < ApplicationController
  before_filter :current_user
  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @polls }
    end
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    @poll = Poll.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @poll }
    end
  end

  # POST /polls
  # POST /polls.json
  def create
    @event = @current_user.events.find_by_id(params[:event_id])
    @poll = @event.polls.new(:n_options => params[:options])
		
    if @poll.save
				#tell buttons to update
				broadcast "/button/#{@event.id}",	{:poll_id => @poll.id, :options => params[:options]}
	
        redirect_to graph_path(@event, :poll_id => @poll.id)
    else
      flash[:error] = "Could not create new poll"
			redirect_to event_path(@event)
    end
  end


	def update
		@event = @current_user.events.find_by_id(params[:event_id])
    @poll = @event.polls.find_by_id(params[:id])

		@poll.multiple = params[:multiple] if params[:multiple]
		@poll.receives_votes = params[:receives_votes] if params[:receives_votes]
		@poll.animation = params[:animate_results] if params[:animate_results]
		
		@poll.save
		render :text => "OK"
	end


  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    respond_to do |format|
      format.html { redirect_to polls_url }
      format.json { head :ok }
    end
  end

	def graph
		#redirects to events#graph action
		redirect_to graph_path(params[:event_id], :poll_id => params[:id])
	end

end
