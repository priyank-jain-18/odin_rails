require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
		@second_user = users(:archer)
	end

	test "unsuccessful edit" do 
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		
		patch user_path(@user),params: {user: {name: "",email: "asd",
		 password: "foo", password_confirmation: "xxx"}}

		assert_template 'users/edit'
		assert_select 'div.alert', "The form contains 4 errors." #.alert is the class
	end

	test "successful edit with friendly forwading" do
		get edit_user_path(@user)
		assert_equal session[:forwarding_url], 	edit_user_url(@user)
		log_in_as(@user)		
		assert_redirected_to edit_user_url(@user)
		assert_nil session[:forwarding_url]

		name = "Tester"
		email = "tester@gmail.com"

		patch user_path(@user),params: {user: {name: name, email: email,
		password: "", password_confirmation: ""}}

		assert_not flash[:success].empty?
		assert_redirected_to @user
		@user.reload #makes variables to date with database
		assert_equal name, @user.name
		assert_equal email, @user.email
	end

	test "should redirect edit when not logged in" do
		get edit_user_path(@user)
		assert_not flash[:danger].empty?

		assert_redirected_to login_url
	end

	test "should redirect update when not logged in" do
		patch user_path(@user), params: { user: 
			{name: @user.name, email: @user.email}}

		assert_not flash[:danger].empty?
		assert_redirected_to login_url
	end


	test "should redirect edit when logged in as wrong user" do
		log_in_as(@second_user)
		get edit_user_path(@user)
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
		log_in_as(@second_user)
		patch user_path(@user), params: { user: 
			{name: @user.name, email: @user.email}}
		assert flash.empty?
		assert_redirected_to root_url
	end


end
