# Load the rails application
require File.expand_path('../application', __FILE__)

#Set if pollster is to be used locally or globally
POLLSTER_ENV = ENV["POLLSTER_ENV"] || "local"
#POLLSTER_ENV = "global" this will make pollster use subdomains

POLLSTER_URL = ENV["POLLSTER_URL"] || "pollster.it"
POLLSTER_HOSTNAME = ENV["POLLSTER_HOSTNAME"] || "pollster.it"

# Initialize the rails application
Pollster::Application.initialize!
