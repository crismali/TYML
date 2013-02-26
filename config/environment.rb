# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TYML::Application.initialize!

# Configuration for using SendGrid on Heroku
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "npostolovski",
  :password => "F3Rw$mjL*uAu",
  :domain => "floating",
  :address => "http://floating-springs-9521.herokuapp.com/",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}