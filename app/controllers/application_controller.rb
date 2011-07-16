class ApplicationController < ActionController::Base
  protect_from_forgery
  def current_user
    @current_user = User.find_by_id(session[:user_id])
		unless @current_user
			redirect_to new_session_path
		end
  end


	def broadcast(channel, msg)
		message = {:channel => channel, :data => msg.to_json}
		#CHANGE=
		uri = URI.parse("http://#{request.host}:9292/faye")
		Net::HTTP.post_form(uri, :message => message.to_json)
	end

end
