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


	test "login with valid information followed by logout" do
		get login_path
		post login_path, params: { session: {email: @user.email, password: 'password'}}

		assert_redirected_to @user
		follow_redirect!

		assert is_logged_in?

		assert_template 'users/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", user_path(@user)

		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		#simulates a user clicking logout in second window
		delete logout_path
		follow_redirect!
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path, count = 0
		assert_select "a[href=?]", user_path(@user),count = 0


	end


end
