require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(username: "tester", email: "user@gmail.com",
		 password: "tester123", password_confirmation: "tester123")
	end

	test "setup should be valid" do 
		assert @user.valid?
	end

	test "whitespace username should not be allowed" do
		@user.username = "        "
		assert @user.valid? == false
		@user.username = "123 asdasd"		
		assert @user.valid? == false
	end

	test "username length should be valid" do
		@user.username = "123"
		assert @user.valid? == false		
	end

	test "username should only work with letters and numbers" do
		@user.username = "!*@&#@@@@"
		assert @user.valid? == false 
	end

	test "email validation should be valid" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]

  		valid_addresses.each do |valid_address|                          
  			@user.email = valid_address
  			assert @user.valid?
  		end
    end

    test "password should have a minimum of 6 characters" do
    	@user.password = "xX" 
    	assert @user.valid? == false
    end

    test "password should have a maxumum of 55 characters" do
    	@user.password = " "
    	assert @user.valid? == false
    end
    	   
end
