class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper #this was included so that session helper is available to all and will enable logging in
end
