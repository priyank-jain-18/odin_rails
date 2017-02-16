require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
	end

	test "login with invalid information" do 
		get login_path
		assert_template 'sessions/new'
		post login_path, params: {session: {email: "", password: "xxx"}}
		assert_template 'sessions/new'
		assert_not flash[:danger].empty?, "there should be a flash danger"		

		get root_path
		assert flash.empty?, "flash should not persist when switching pages"		
	end

	test "login with valid information followed by a logout" do
		get login_path
		assert_template 'sessions/new'

		post login_path, params: {session: { email: @user.email, password: 'password' }}

		assert is_logged_in?, "user should be logged in"
		assert_redirected_to @user
		follow_redirect!
		assert_template 'users/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path,count: 1
		assert_select "a[href=?]", user_path(@user),count: 1

		delete logout_path
		assert_redirected_to root_url
		follow_redirect!
		assert_select "a[href=?]", login_path, count: 1
		assert_select "a[href=?]", logout_path, count: 0
		assert_select "a[href=?]", user_path(@user),count: 0
	end


end
