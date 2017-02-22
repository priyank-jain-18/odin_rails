require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
		@user2 = users(:archer)
	end

	test "should get new" do
    	get signup_path
    	assert_response :success
  	end

  	test "should redirect update when not logged in" do 
  		patch user_path(@user),params: {user: {name: @user.name, email: @user.email}}

  		assert_not flash[:danger].empty?
  		assert_redirected_to login_url
  	end

  	test "should not allow admin attribute to be edied via the web" do
  		log_in_as(@user2)
  		assert_not (@user2).admin?
  		patch user_path(@user2), params: { user:{password: "tester123",
  		 password_confirmation: "tester123",admin: true}}

  		assert_not @user2.admin?
  	end

  	test "should redirect destroy when not logged in" do
  		assert_no_difference 'User.count' do
  			delete user_path(@user)
  		end
  		assert_redirected_to login_url
  	end

  	test "should redirect to root when destroying as a non admin" do
  		log_in_as(@user2)
  		assert_no_difference 'User.count' do
  			delete user_path(@user) 
  		end
  		assert_redirected_to root_url
  	end

end
