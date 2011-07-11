class SessionsController < ApplicationController
	layout "outside"
  def new
		redirect_to events_path if User.find_by_id(session[:user_id])
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to events_path
    else
      flash.now[:error] = "Email or password is incorrect"
      render :action => "new", :layout => false
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

end
