class MassUsersInvitation < ApplicationRecord
	belongs_to :event
    before_validation :multiple_users, length: {in: 1..520}

    validates :multiple_users, presence: true

	validate :user_name_validity
	validate :maximum_users
	validate :cannot_invite_self

	before_save false

	private

	def user_name_validity #checks if username/user has already been invited or invalid				
		users = self.multiple_users.gsub(/\s+/, "").split(',').uniq		
		event = Event.find(self.event_id)

		 missing_users = Array.new		
		 already_invited_users = Array.new

		users.each do |username| #searches if usernames are there
			if User.find_by(username: username).nil? 
				missing_users << username 
			elsif event && event.attendees.find_by(invited_user: username).present?				
			    already_invited_users << username 
			end
		end		

		if missing_users.any? 
			missing_users_message = "Users not found: "
			missing_users.each{|user| missing_users_message << "#{user} "}
			errors.add(:missing_users, missing_users_message)
		end
		if already_invited_users.any?

			already_invited_users_message = "You have already invited the following users: "
			already_invited_users.each{|user| already_invited_users_message << "#{user} "}
			errors.add(:already_invited_users, already_invited_users_message)
		end

		self.multiple_users = users.join(',')
	end

	def maximum_users
		if self.multiple_users.split(',').count > 30
			errors.add(:maximum_users, "Maximum invites is only 30")
		end
	end

	def cannot_invite_self				
		if self.multiple_users.split(',').include?(self.event.creator.username)
			errors.add(:cannot_invite_self, "You cannot invite yourself")
		end
	end


end
