# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bloomberg::Application.initialize!

ActionMailer::Base.smtp_settings = {
	user_name: 'contego',
	password: 'bloomberg1',
	domain: 'dymaxi.com',
	address: 'smtp.sendgrid.net',
	port: 587,
	authentication: :plain,
	enable_starttls_auto: true
}