class Event < ApplicationRecord
	belongs_to :creator, class_name: "User"
	has_many :attendees,
	 class_name: "Invitation", foreign_key: "attended_event_id", dependent: :destroy

	has_many :mass_invitations, class_name: "MassUsersInvitation", foreign_key: "event"

	default_scope -> {order(created_at: :desc)}	
	
	validates :title, presence: true, length: {in: 4..25}
	validates :description, presence: true, length: {in: 4..400}
	validates :event_start_date, presence: true

end
