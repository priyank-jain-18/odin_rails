class Event < ApplicationRecord
	belongs_to :creator, class_name: "User", optional: true
	has_many :attendees, class_name: "User", foreign_key: "attended_event"


	default_scope -> {order(created_at: :desc)}
	

	validates :title, presence: true, length: {in: 4..25}
	validates :description, presence: true, length: {in: 4..120}
end
