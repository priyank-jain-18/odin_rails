class Invitation < ApplicationRecord
	belongs_to :event

	#validates :invited_user, presence: true
end
