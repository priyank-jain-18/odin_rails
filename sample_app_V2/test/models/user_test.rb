require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Test User", email: "tester@gmail.com",
			password: "tester123", password_confirmation: "tester123")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "blank name should not be valid" do
		@user.name = "    "
		assert_not @user.valid?		
	end

	test "blank email should not be valid" do
		@user.email = "     "
		assert_not @user.valid?
	end

	test "name should not be more than 50 characters" do
		@user.name = 'x' * 51  #51 characters
		assert_not @user.valid?
	end

	test "email should not be more than 255 characters" do
		@user.email = 'x' * 244 + "@example.com" #this is 256 characters
		assert_not @user.valid?
	end

	test "email should accept valid addresses" do
		valid_addresses = %w[test@gmail.com TEST@gmail.CoM A_US-ER@gmail.bar.org
                         first.last@gmail.jp alice+bob@gmail.cn]
        
        valid_addresses.each do |email_address|
        	@user.email = email_address
        	assert @user.valid?, "#{email_address} should be valid"
        end
    end

    test "email should NOT accept INVALID addresses" do
    	invalid_addresses = %w[test@gmail,com user_at_gmail.org user.name@gmail.com. 
    		tester@gmail_asd.com test@test1+baz.com asdasdasdasd@gmail..com]

    	invalid_addresses.each do |invalid_email|
    		@user.email = invalid_email
    		assert_not @user.valid?, "#{invalid_email} should be invalid"
    	end
    end

    test "email should have no duplicates in the database" do
 		duplicate_user = @user.dup #dup means another duplicate user from setup
 		@user.save
 		assert_not duplicate_user.valid?

 		duplicate_user.email = @user.email.upcase #should be case insensitive 
 		assert_not duplicate_user.valid?, "should be case insensitive"
 	end

 	test "emails should be saved as downcase" do
 		@user.email = "TeSTEr@GmAIL.CoM"
 		@user.save

 		assert_equal @user.email.downcase, @user.reload.email
 	end

 	test "passwords should be invalid when blank" do
 		@user.password = @user.password_confirmation = "     "
 		assert_not @user.valid?
 	end

 	test "password should have a minimum length of 6" do
 		@user.password = @user.password_confirmation = 'x' * 5
 		assert_not @user.valid?
 	end

 	test "password should have a maximum length of 75" do
 		@user.password = @user.password_confirmation = 'x' * 76
 		assert_not @user.valid?
 	end

 	test "authenticates should return false when remember_digest is false" do
 		assert_not @user.authenticated?('xxxxx')
 	end

end
