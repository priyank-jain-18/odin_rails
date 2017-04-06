require 'test_helper'

class BookingTest < ActiveSupport::TestCase	

	def setup
		@booking = Booking.new(flight: flights(:one))	
	end	

	test "should be valid" do
		assert @booking.valid?
	end

	test "should accept passengers" do
	    @booking.save
		@booking.passengers.build(name: "Jhon Jaworski", email: "justatest@gmail.com")		
		assert @booking.valid?
		@booking.save
		assert_equal 1,  @booking.passengers.count
	end




end
