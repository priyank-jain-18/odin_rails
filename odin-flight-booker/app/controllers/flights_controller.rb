class FlightsController < ApplicationController

  def index   	
  	initialize_form_objects  
  	map_submmited_info_and_check_for_errors  
  end  



  private

  def initialize_form_objects
  	@flights = Flight.all  	
  	@flights_from_list =  @flights.select("departed_from_id").
  		distinct.map { |flight| [flight.departed_from.name, flight.departed_from.id]}
  	@flights_to_list = @flights.select("arriving_to_id").
  		distinct.map{|flight| [flight.arriving_to.name, flight.arriving_to.id]}
  	@departure_dates_to_list =	@flights.select("departure_date_time").
  		distinct.map{|flight| [flight.departure_date_time.strftime("%m/%d/%Y"),
  		 flight.departure_date_time]}

  	@number_of_passengers = (1..4).to_a  											 
  end

  def map_submmited_info
  	@flights.where("departed_from_id = ? 
  		AND arriving_to_id = ? AND departure_date_time between ? and ? ",
  		params[:flights][:departed_from],
  		params[:flights][:arriving_to],
  		params[:flights][:departure_date].to_datetime - 1.second,
  		params[:flights][:departure_date].to_datetime + 1.second).
  			map{|flight| ["From #{flight.departed_from.name} 
  			to #{flight.arriving_to.name}", flight.id]}
  end

  def map_submmited_info_and_check_for_errors
  	if params[:flights] && !params[:flights].value?("")   		
  		@custom_flights = map_submmited_info
  		flash.now[:info] = "No flights have been found" if 
  			@custom_flights && @custom_flights.empty?  			  			  			  	
  	elsif params[:flights] && params[:flights].value?("")
  		flash.now[:danger] = "You have missing entries in your form"
  	end
  end

end
