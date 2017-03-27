class EventsController < ApplicationController
before_action :logged_in_users_only, only: :create

  def create
  	@event = current_user.events.build(event_params)    
    redirect_to root_url if @event.creator != current_user
  	if @event.save 
  		redirect_to root_url
  	else      
      render 'new'
  	end
  end

  def show
  	@event = Event.find(params[:id])
    @attendees = @event.attendees.where(accepted: true).paginate(page: params[:page])
    if session[:mass_user_errors].present?
      @invite_users = @event.mass_invitations.build                    
      @invite_users.multiple_users = session[:mass_user_list]      
      mass_users_display_errors
    else
      @invite_users = @event.mass_invitations.build             
    end
     
  end

  def index
  	@events = Event.all
  end

  private

 	def event_params
 		params.require(:event).permit(:title,:description,:event_start_date )
 	end

  def mass_users_display_errors
    session[:mass_user_errors].each do |type,error_message|            
       @invite_users.errors.add(" ","#{error_message}".to_s.gsub(/[\[\]\"\\]/,""))
    end  
    session.delete(:mass_user_list)
    session.delete(:mass_user_errors)
  end

end
