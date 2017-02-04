require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest


	test "login with invalid information" do 

		get login_path       #verify the login path
		assert_template 'sessions/new'    #verift the new session renders works
		post login_path, params: { session: {email: "", password: ""}}    #post to the session an invalid params
		assert_template 'sessions/new'   #verify that the form gets rerendered
		assert flash.empty? == false      #verify that a flash appears
		
		get root_path      #goes to root path
		assert flash.empty?    # verify that flash does not appear in new page
	end


end
