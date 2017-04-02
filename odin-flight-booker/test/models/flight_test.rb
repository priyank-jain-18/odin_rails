require 'test_helper'

class FlightTest < ActiveSupport::TestCase

	def setup 
		airport = airports(:one)
		airport2 = airports(:two)	

		#Time for Time.new is Time.new(:years, :months, :days, :hours, :minutes, :seconds)
		#Time.new(2002, 10, 31, 2, 2, 2, "+02:00") #=> 2002-10-31 02:02:02 +0200		
		departure = Time.new(2019,1,13,12,30)#2019-01-13 12:30:00 
		arrival = departure + 2.hours			

		@flight = airport.departing_flights.build(arriving_to: airport2,
			departure_date_time: departure, arrival_date_time: arrival )
	end

	test "flight should be valid" do		
		assert @flight.valid?
	end

	test "should not have empty departure" do				
		@flight.arriving_to_id = nil
		assert_not @flight.valid?		
	end

	test "should not have empty arriving" do
		@flight.departed_from_id = nil
		assert_not @flight.valid?
	end	

	test "arrival_date_time and departure_date_time should not be empty" do
		@flight.arrival_date_time = nil
		assert_not @flight.valid?

		@flight.departure_date_time = nil
		assert_not @flight.valid?
	end

	test "arrival_date_time should have time greater than departure_date_time" do
		arrival = @flight.arrival_date_time - 10.hours
		@flight.arrival_date_time = arrival
		assert_not @flight.valid?	
	end



end
