class StaticPagesController < ApplicationController
  def home
  	if logged_in?  		
  		@event = current_user.events.build	  	
  		@created_events_feed = current_user.events.paginate(page: params[:page],per_page: 4) 
  		@attending_events_feed = Event.joins(:attendees).where("invitations.accepted = ? AND invitations.invited_user = ?",
  			true, current_user.username).paginate(page: params[:page], per_page: 4)
  		
  		#Invitation.where(invited_user: current_user.username, accepted: true).paginate(page: params[:page],per_page: 4)  		
  	end
  end


  
end
