# Load the rails application
require File.expand_path('../application', __FILE__)

#Set if pollster is to be used locally or globally
#POLLSTER_ENV = "local"
POLLSTER_ENV = "global"

POLLSTER_URL = "pollster.mlinux.ath.cx"

# Initialize the rails application
Pollster::Application.initialize!
