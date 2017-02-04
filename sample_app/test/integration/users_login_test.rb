require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)

	end


	test "login with invalid information" do 

		get login_path       #verify the login path
		assert_template 'sessions/new'    #verift the new session renders works
		post login_path, params: { session: {email: "", password: ""}}    #post to the session an invalid params
		assert_template 'sessions/new'   #verify that the form gets rerendered
		assert flash.empty? == false      #verify that a flash appears
		
		get root_path      #goes to root path
		assert flash.empty?    # verify that flash does not appear in new page
	end


	test "login with valid information" do
		get login_path
		post login_path, params: { session: {email: @user.email, password: 'password'}}

		assert_redirected_to @user
		follow_redirect!

		assert_template 'users/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", user_path(@user)

	end


end
