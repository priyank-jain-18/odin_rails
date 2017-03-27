module InvitationsHelper

	def current_user_invitations#returns events where
		Invitation.joins(:attended_event).where("invitations.invited_user = ? AND invitations.accepted = ? AND events.event_start_date > ?",
			current_user.username, false, Time.zone.now)
	end

	def delete_old_current_user_invitations
 		Invitation.joins(:attended_event).where("invitations.invited_user = ? AND invitations.accepted = ? AND events.event_start_date < ?",
      	current_user.username, false, Time.zone.now).delete_all
 	end
end