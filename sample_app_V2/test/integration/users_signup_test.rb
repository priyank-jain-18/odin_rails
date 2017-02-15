require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "should render new when invalid signup information" do
    get signup_path
    assert_no_difference 'User.count', 1 do
      post signup_path, params: { user: { name:  "     ",
                                         email: "user@invalid",
                                         password:              "@#s",
                                         password_confirmation: "1;3" } }
    end
    assert_template 'users/new'    #new renders when failed
    assert_select 'form[action="/signup"]'  #detects that it goes through post signup_path and not post users_path

  end

  test "should render show when valid signup info" do
  	get signup_path 
  	assert_difference 'User.count', 1 do
  		post signup_path,
  		params: {user: {name: "Tester", 
  			email: "testering@gmail.com",
  			password: "tester123",
  			password_confirmation: "tester123"}}
  	end
  	follow_redirect!
  	assert_template 'users/show'
  	assert_not flash[:success].empty?
  end




end