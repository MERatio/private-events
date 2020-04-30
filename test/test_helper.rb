ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper

  # Returns a boolean if a test user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Log in as a user based on user parameter
  def log_in_as(email, password, remember_me)
    post login_path, params: { session: { email: email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end
