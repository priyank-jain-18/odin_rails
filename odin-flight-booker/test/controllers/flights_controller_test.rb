require 'test_helper'

class FlightsControllerTest < ActionDispatch::IntegrationTest

	test "should get proper index" do		
		get flights_path
		assert_response :success		
		assert_template "flights/index"
		assert_select "title", "Flight Booker"
		assert_select "a[href=?]", root_path, count: 1
		assert_select 'form[action="/flights"]',count: 1
	end

	test "root should be flights/index" do		
		get root_path
		assert_response :success		
		assert_template "flights/index"
	end

end
