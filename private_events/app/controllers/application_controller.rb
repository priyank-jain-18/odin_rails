class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper 


  def not_allowed_when_logged_in
	redirect_to root_url if logged_in?	
  end  


end
