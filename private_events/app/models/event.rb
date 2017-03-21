class Event < ApplicationRecord
	belongs_to :creator, class_name: "User"
	has_many :attendees,
	 class_name: "Invitation", foreign_key: "attended_event", dependent: :destroy

	default_scope -> {order(created_at: :desc)}	
	
	validates :title, presence: true, length: {in: 4..25}
	validates :description, presence: true, length: {in: 4..120}
end
