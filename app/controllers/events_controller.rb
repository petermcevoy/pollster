class EventsController < ApplicationController
  before_filter :current_user
  
  def index
    @events = @current_user.events.all
  end

  def show
    @event = @current_user.events.find(params[:id])
  end

  def new
    @event = @current_user.events.new
  end

  def edit
    @event = @current_user.events.find(params[:id])
  end

  def create
    @event = @current_user.events.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, :notice => 'Event was successfully created.' }
        format.json { render :json => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @event = @current_user.events.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to @event, :notice => 'Event was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @event = @current_user.events.find(params[:id])
    @event.destroy
    redirect_to events_url
  end
  
  def start
    #starts a new poll if there is'nt one already
    @event = @current_user.events.find_by_id(params[:id])
    
  end
  
  def graph
     @event = @current_user.events.find_by_id(params[:id])
     render :layout => false
  end
  
end
