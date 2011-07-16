module ApplicationHelper
	def broadcast(channel, &block)
		message = {:channel => channel, :data => capture(&block)}
		#CHANGE=
		uri = URI.parse("http://#{request.host}:9292/faye")
		Net::HTTP.post_form(uri, :message => message.to_json)
	end
end
