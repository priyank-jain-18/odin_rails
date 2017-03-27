class InvitationsController < ApplicationController
before_action :logged_in_users_only
before_action :correct_user, only: [:update,:destroy]


  def update
     @invitation.update_attributes(accepted: true)
     redirect_to root_url
  end

  def index
    @invitations = current_user_invitations.paginate(page: params[:page], per_page: 10)
    #debugger
  end
  
  def destroy       
    @invitation.destroy     
    if params[:referrer] == "events page"
      flash[:info] = "kicked #{@invitation.invited_user}" 
      redirect_to @invitation.attended_event and return  
    end
    redirect_to invitations_path  
  end


  private

  def correct_user    
    @invitation = Invitation.find(params[:id])
    invited_user = User.find_by(username: @invitation.invited_user)     
    redirect_to root_url if current_user != invited_user && current_user != @invitation.attended_event.creator
  end

end
