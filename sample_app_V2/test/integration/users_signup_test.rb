require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

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
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'

  end

  test "should render show when valid signup info + account activation" do
  	get signup_path 
  	assert_difference 'User.count', 1 do
  		post users_path,
  		params: {user: {name: "TesterFuvk", 
  			email: "testeringer@gmail.com",
  			password: "tester123",
  			password_confirmation: "tester123"}}
  	end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    assert user.valid?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?

    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end




end