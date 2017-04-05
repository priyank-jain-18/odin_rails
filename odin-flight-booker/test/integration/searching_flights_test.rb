require 'test_helper'

class SearchingFlightsTest < ActionDispatch::IntegrationTest

	test "missing fields should show a warning" do		
		get flights_path, params: { flights: {departed_from: ""}}		
		assert_not_nil flash[:danger]


		get flights_path
		assert_nil flash[:danger]#makes sure that flash is gone
	end

	test "missing fields with some not should still show a warning" do
		get flights_path, params: { flights: {departed_from: "",
			arrival_date_time: Time.zone.now + 2.hours}}
		assert_not_nil flash[:danger]
	end

	test "should show an info when no flights are found" do
		get flights_path, params: {
			flights: {departed_from: 2,
			arriving_to: 1,
			departure_date:  Time.zone.now + 2.hours,
			number_of_passengers: 1 }}
		assert_not_nil flash[:info]

		assert_select "form[action=\"/bookmarks/new\"]", count: 0
		get flights_path
		assert_nil flash[:info]#makes sure that flash is gone
	end

	test "search should post properly" do	
		get flights_path	
		assert_select "form[action=\"/bookmarks/new\"]", count: 0		
		get flights_path, params: {
			flights: {departed_from: 1,
			arriving_to: 2,
			departure_date:  Time.zone.now + 2.hours,
			number_of_passengers: 1 }}
		assert_select "form[action=\"/bookmarks/new\"]", count: 1	
		assert_select "form[action=\"/flights\"]", count: 1
	end
=begin
	test "bookmarks should GET information properly" do
		get new_bookmark_path, params: {
			flight_id: 1,
			number_of_passengers: 1		
		}		
	end
=end


end

