require 'test_helper'

class BookingsTest < ActionDispatch::IntegrationTest
  	
  	def setup
    	ActionMailer::Base.deliveries.clear
  	end	

	test "booking with invalid users should not work" do	
		assert_no_difference 'Passenger.count' do
			post bookings_path, params: {booking: {
				flight_id: 1, passengers_attributes: { 
					"0" => {name: "tester", email: "tester@gmail.com"},
					"1" => {name: "fool", email: "tester@gmail.com"} }}}
		end
		assert_redirected_to new_booking_path(flight_id: 1, number_of_passengers: 2)		
		assert_not_nil flash[:danger]
		assert_equal 0, ActionMailer::Base.deliveries.size
	end

	test "booking should work" do	
		assert_difference 'Passenger.count', 2 do
			post bookings_path, params: {booking: {
				flight_id: 1, passengers_attributes: { 
					"0" => {name: "tester", email: "tester@gmail.com"},
					"1" => {name: "testeringo", email: "testeringo@gmail.com"}}}}
		end
		follow_redirect!
		assert_match "Succesfully booked ticket!", response.body
		assert_template "bookings/show"
		assert_equal 2, ActionMailer::Base.deliveries.size
	end
end
