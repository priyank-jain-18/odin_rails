require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

	test "root should be flights/index" do		
		get root_path
		assert_response :success		
		assert_template "flights/index"
	end
end