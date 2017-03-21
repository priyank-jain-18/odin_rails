class StaticPagesController < ApplicationController
  def home
  	if logged_in?  		
  		@event = current_user.events.build	  	
  		@events_feed = @current_user.events.paginate(page: params[:page])  
  		#debugger		
  	end
  end
end
