Pollster::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = false

  # For containers we want everything hosted through rails's static asset server.
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.manifest = Rails.root.join("public/assets")
  config.assets.compress = true
  config.assets.compile = false
  config.assets.digest = true
  config.assets.precompile += %w( button.js  graph.js responses.js)

  # Specify the default JavaScript compressor
  #config.assets.js_compressor  = :uglifser

  # Specifies the header that your server uses for sending files
  # (comment out if your front-end server doesn't support this)
  config.action_dispatch.x_sendfile_header = "X-Sendfile" # Use 'X-Accel-Redirect' for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = false

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

	#TLD-size
  TLD_SIZE = ENV["TLD_SIZE"].to_i || 1
	
end
