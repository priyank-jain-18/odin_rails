require 'test_helper'

class AirportTest < ActiveSupport::TestCase

	def setup
		@airport = Airport.new(name: "SFO")
	end

	test "should be valid" do
		assert @airport.valid?
	end

	test "name should not be empty" do
		@airport.name = ""
		assert_not @airport.valid?
		@airport.name = nil
		assert_not @airport.valid?
	end

	test "name should be only 3 characters" do
		@airport.name = "xx"
		assert_not @airport.valid?
		@airport.name = "xxxx"
		assert_not @airport.valid?
		@airport.name = "xxx"
		assert @airport.valid?
	end	
end
