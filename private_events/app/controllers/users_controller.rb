class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	@user.save ? redirect_to root_url : render 'new'  	
  end

  def show
  	@user = User.find(params[:id])
  end

  private
  	def user_parms
  		params.require(:user).permit(:username, :email, :password, :password_confirmation)
  	end
end
