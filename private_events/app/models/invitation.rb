class Invitation < ApplicationRecord
	belongs_to :attended_event, class_name: "Event"

    validate :cannot_invite_self
	validates :invited_user, presence: true
	
	private
	
	def cannot_invite_self		
		if self.attended_event.creator.username == invited_user
			errors.add(:invited_user, "You cannot invite yourself ")
		end
	end
end
