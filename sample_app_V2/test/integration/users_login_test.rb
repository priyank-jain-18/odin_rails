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

		#simulates another user clicking logout in another window
		delete logout_path
		follow_redirect!
		assert_select "a[href=?]", login_path, count: 1
		assert_select "a[href=?]", logout_path, count: 0
		assert_select "a[href=?]", user_path(@user),count: 0
	end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end

  test "login should redirect to root when not activated" do
  	log_in_as(users(:non_activated))
  	assert_redirected_to root_url
  	assert_not_empty flash[:warning]
  end

end
