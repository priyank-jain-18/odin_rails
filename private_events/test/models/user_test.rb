require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
	def setup
		@user = User.new(username: "testering",password: "tester123",email: "testering@gmail.com")
	end

	test "user should be valid" do		
		assert @user.valid?
	end

	test "username should now allow spaces" do
		@user.username = " testering"
		assert_not @user.valid?
		@user.username = "tester ing"
		assert_not @user.valid?
	end

	test "username should not allow special characters" do
		@user.username = "^*^&#$}" 
		assert_not @user.valid?
	end

	test "username maximum of 16 characters only" do
		@user.username = 'x' * 17
		assert_not @user.valid?
		@user.username = 'x' * 16
		assert @user.valid?
	end

	test "username minimum of 4 characters only" do
		@user.username = 'x' * 3
		assert_not @user.valid?
		@user.username = 'x' * 4
		assert @user.valid?
	end

	test "username duplicates are not allowed" do
		duplicate_user = User.new(username: "testering",
			password: "tester123",email: "testering123@gmail.com")
		@user.save
		assert_not duplicate_user.valid?
	end

	test "username should be case insensitive" do
		duplicate_capslock_user = User.new(username: "TESTERING",
			password: "tester123",email: "testering123@gmail.com")
		@user.save
		assert_not duplicate_capslock_user.valid?
	end

	test "email should not be more than 255 characters" do
		@user.email = 'x' * 244 + "@example.com" #256 characters
		assert_not @user.valid?
	end

	test "email should accept valid addresses" do
		valid_addresses = %w[test@gmail.com TEST@gmail.CoM A_US-ER@gmail.bar.org
                         first.last@gmail.jp alice+bob@gmail.cn]
        
        valid_addresses.each do |email_address|
        	@user.email = email_address
        	assert @user.valid?
        end
    end

    test "email should NOT accept INVALID addresses" do
    	invalid_addresses = %w[test@gmail,com user_at_gmail.org user.name@gmail.com. 
    		tester@gmail_asd.com test@test1+baz.com asdasdasdasd@gmail..com]

    	invalid_addresses.each do |invalid_email|
    		@user.email = invalid_email
    		assert_not @user.valid?
    	end
    end

    test "email should have no duplicates" do
 		duplicate_user = User.new(username: "testeringer",
 			password: "tester123",email: "testering@gmail.com")
 		@user.save
 		assert_not duplicate_user.valid?
 	end


 	test "capslock email should not register into database" do
 		duplicate_user = @user.dup
 		duplicate_user.username = "asdasdas123"
 		duplicate_user.email.upcase! 		
 		@user.save

 		duplicate_user.email = @user.email.upcase #should be case insensitive 
 		assert_not duplicate_user.valid?
 	end

	test "password should now allow spaces" do
		@user.password = " testering"
		assert_not @user.valid?
		@user.password = "tester ing"
		assert_not @user.valid?
	end

	test "password maximum of 69 characters only" do
		@user.password = 'x' * 70
		assert_not @user.valid?
		@user.password = 'x' * 69
		assert @user.valid?
	end

	test "password minimum of 6 characters only" do
		@user.password = 'x' * 5
		assert_not @user.valid?
		@user.password = 'x' * 6
		assert @user.valid?
	end



end
