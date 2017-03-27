module EventsHelper

	def no_attendees?(event) #returns true if event has no attendees		
		!event.attendees.where(accepted: true).any?
	end

	def event_ended?(event) #returns true if event start date has passed 
		return Time.zone.now > event.event_start_date 
	end

	def event_attendees(event) #returns attendees who have have accepted the invitation
		Invitation.where(attended_event: event.id, accepted: true)
	end

	def username_to_user(user)
		User.find_by(username: user)
	end
	
end
