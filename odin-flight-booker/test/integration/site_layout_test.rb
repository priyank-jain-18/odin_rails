require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

	test "should get proper root" do		
		get root_path
		assert_response :success		
		assert_template "flights/index"
		assert_select "title", "Flight Booker"
		assert_select "a[href=?]", root_path, count: 1
	end
end