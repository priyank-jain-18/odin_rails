class MassUsersInvitationsController < ApplicationController

  def create
  	event = Event.find(params[:event_id])
    redirect_to root_url and return if event.creator != current_user
  	mass_users = event.mass_invitations.build(user_list_params)

    if mass_users.valid?      
      mass_users.multiple_users.split(',').each do |username|
        event.attendees.build(invited_user: username).save
      end
      flash[:info] = "successfully invited users!" 
      redirect_to event_path(event)   
    else #adds errors for redirection      
     session[:mass_user_errors] = mass_users.errors.messages
     session[:mass_user_list] = mass_users.multiple_users     
     redirect_to event_path(event)
    end
  end

  private

  def user_list_params
  	params.require(:mass_users_invitation).permit(:multiple_users)
  end
end