require 'test_helper'

class PassengerTest < ActiveSupport::TestCase
	def setup
		@passenger = Passenger.new(name: "tester123",
			email: "tester123@gmail.com", booking: bookings(:one))
	end

	test "should be valid" do		
		assert @passenger.valid?
	end


	test "blank name should not be valid" do
		@passenger.name = "    "
		assert_not @passenger.valid?		
	end

	test "blank email should not be valid" do
		@passenger.email = "     "
		assert_not @passenger.valid?
	end


	test "email should not be more than 255 characters" do
		@passenger.email = 'x' * 244 + "@example.com" #this is 256 characters
		assert_not @passenger.valid?
	end

	test "email should accept valid addresses" do
		valid_addresses = %w[test@gmail.com TEST@gmail.CoM A_US-ER@gmail.bar.org
                         first.last@gmail.jp alice+bob@gmail.cn]
        
        valid_addresses.each do |email_address|
        	@passenger.email = email_address
        	assert @passenger.valid?, "#{email_address} should be valid"
        end
    end


    test "email should NOT accept INVALID addresses" do
    	invalid_addresses = %w[test@gmail,com passenger_at_gmail.org passenger.name@gmail.com. 
    		tester@gmail_asd.com test@test1+baz.com asdasdasdasd@gmail..com]

    	invalid_addresses.each do |invalid_email|
    		@passenger.email = invalid_email
    		assert_not @passenger.valid?, "#{invalid_email} should be invalid"
    	end
    end

    test "email should have no duplicates in the database" do
 		duplicate_passenger = @passenger.dup #dup means another duplicate passenger from setup
 		@passenger.save
 		assert_not duplicate_passenger.valid?

 		duplicate_passenger.email = @passenger.email.upcase #should be case insensitive 
 		assert_not duplicate_passenger.valid?, "should be case insensitive"
 	end

 	test "emails should be saved as downcase" do
 		@passenger.email = "TeSTEr@GmAIL.CoM"
 		@passenger.save

 		assert_equal @passenger.email.downcase, @passenger.reload.email
 	end


end
