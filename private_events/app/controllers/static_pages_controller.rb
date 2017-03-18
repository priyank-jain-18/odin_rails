class StaticPagesController < ApplicationController
  def home
  	if logged_in?  		
  		@event = current_user.events.build	  	
  		@events_feed = @current_user.events_feed.paginate(page: params[:page])  		
  	end
  end
end
