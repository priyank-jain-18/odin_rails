class User < ApplicationRecord
	before_save :downcase_email

	has_many :events, class_name: "Event", foreign_key: :creator_id
	has_many :invitations, through: :events, source: :attendees

	has_many :invitation_requests, class_name: "Invitation", foreign_key: :invited_user

	#VALIDATION
	#username
	LETTERS_AND_NUMBERS_ONLY = /\A[a-zA-Z0-9]*\z/
	validates :username, presence: true, length: {in: 4..16},  uniqueness: {case_sensitive: false},
		format: {with: LETTERS_AND_NUMBERS_ONLY, message: "No special characters allowed"}

	#email
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
		uniqueness: {case_sensitive: false}, 
		format: {with: VALID_EMAIL_REGEX}
	#password
	WHITE_SPACE_REGEX = /\s/ 
	validates :password, length: {in: 6..69}, presence: true, allow_nil: true, 
	format: {without: WHITE_SPACE_REGEX, message: "No white spaces in your password"}	
	has_secure_password

	def User.digest(string) #added digest method for password_digest in fixture
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  	BCrypt::Engine.cost
		return BCrypt::Password.create(string, cost: cost) 
	end	

	def events_feed
		Event.where(id: id)
	end

	private

	def downcase_email
		self.email.downcase!
	end	


end
