class EventsController < ApplicationController

  def create
  	@event = current_user.events.build(event_params)
  	if @event.save
  		redirect_to root_url
  	else
  		render 'static_pages/home'
  	end
  end

  def show
  	@event = Event.find(params[:id])
  end

  def index
  	@events = Event.all
  end

  private
  	def event_params
  		params.require(:event).permit(:title,:description)
  	end


end
