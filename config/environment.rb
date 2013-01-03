# Load the rails application
require File.expand_path('../application', __FILE__)

ENV['RAILS_ENV'] ||= 'production'

ENV['JAVA_HOME'] = "/home/ubuntu/jdk1.6.0_35"
ENV['LD_LIBRARY_PATH']="/home/ubuntu/jdk1.6.0_35/lib"

# Initialize the rails application
ShoutoutWeb::Application.initialize!
ShoutoutWeb::Application.configure do
config.action_mailer.delivery_method = :smtp
config.action_mailer.raise_delivery_errors = true
config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'shoutout.co.in',
  :user_name            => 'heartbeat@shoutout.co.in',
  :password             => 'avinashsantosh',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }
end

