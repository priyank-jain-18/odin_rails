require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest

	test "bookings should redirect to root if no params" do
		get new_booking_path
		assert_redirected_to root_url
	end

	test "should redirect to root if invalid flight_id" do
		get new_booking_path, params: {
			flight_id: 250,
			number_of_passengers: 1		
		}
		assert_redirected_to root_url
	end

	test "should redirect to root if invalid number_of_passengers" do
		get new_booking_path, params: {
			flight_id: 1,
			number_of_passengers: 5		
		}
		assert_redirected_to root_url

		get new_booking_path, params: {
			flight_id: 1,
			number_of_passengers: 0
		}
		assert_redirected_to root_url
	end


	test "should not redirect when correct params are added" do		
		get new_booking_path, params: {
			flight_id: 1,
			number_of_passengers: 1		
		}
		assert_response :success
		assert_select 'form[action="/bookings"]',count: 1
	end
	
end
