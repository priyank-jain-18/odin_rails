class FlightsController < ApplicationController

  def index
  	initialize_form_objects
  end  




  private

  def initialize_form_objects
  	@flights = Flight.all
  	@flights_from_list =  @flights.map{|flight| flight.departed_from.name}.uniq
  	@flights_to_list = @flights.map{|flight| flight.arriving_to.name}.uniq
  	@departure_dates_to_list =	@flights.map{|flight| flight.formatted_departure_date}.uniq
  	@number_of_passengers = (1..4).to_a
  end


  
end
