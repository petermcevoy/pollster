class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      #redirect
      render :text => "logged in!"
    else
      flash.now[:error] = "Email or password is incorrect"
      render :action => "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out."
    redirect_to new_session_path
  end

end
