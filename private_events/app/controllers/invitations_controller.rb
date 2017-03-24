class InvitationsController < ApplicationController
before_action :is_event_creator
  
  def destroy
  	event_page = @invitation.attended_event
  	@invitation.destroy
  	redirect_to event_page
  end


  private

  def is_event_creator
  	@invitation = Invitation.find(params[:id])
  	redirect_to root_url unless current_user == invitation.attended_event.creator
  end
end
