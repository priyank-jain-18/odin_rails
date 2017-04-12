require 'test_helper'

class PassengerMailerTest < ActionMailer::TestCase
 
	test "completed_booking" do
		passenger = passengers(:one)
		mail = PassengerMailer.completed_booking(passenger)
		assert_equal "Successfully booked ticket!", mail.subject
		assert_equal [passenger.email], mail.to
    	assert_equal ["noreply@example.com"], mail.from 
    	assert_match passenger.name, mail.body.encoded    	
    	assert_match "booking id: #{passenger.booking.id}", mail.body.encoded
    	assert_match "flight id: #{passenger.booking.flight.id}", mail.body.encoded
    end

end
