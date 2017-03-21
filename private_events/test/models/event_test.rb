require 'test_helper'

class EventTest < ActiveSupport::TestCase

	def setup
		@user = users(:normal_user)
		@event = @user.events.build(title: "Tester123", 
			description: "testing description123")
	end

	test "event should be valid" do
		assert @event.valid?
	end



end
