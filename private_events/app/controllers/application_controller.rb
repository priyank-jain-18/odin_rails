class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper 
  include InvitationsHelper


  def not_allowed_when_logged_in
	redirect_to root_url if logged_in?	
  end  

  def logged_in_users_only  	
  	redirect_to login_path if !logged_in?
  end  
  
end
