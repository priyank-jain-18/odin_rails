class SessionsController < ApplicationController
before_action :not_allowed_when_logged_in, only: [:new, :create]

  def new
  end

  def create
  	@user = User.find_by(email: params[:session][:email].downcase)
  	if @user
  		log_in(@user)
  		redirect_to root_url
  	else
  		flash.now[:danger] = "wrong email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
