class User < ApplicationRecord
  	attr_accessor :remember_token, :activation_token, :reset_token
  	before_save   :downcase_email
  	before_create :create_activation_digest

	#VALIDATIONS

	validates :name,presence: true,length: {maximum: 50}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email,presence: true,length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX},
		uniqueness: {case_sensitive: false}

	validates :password, length: {in: 6..75}, presence: true, allow_nil: true
	has_secure_password

	#METHODS

	def User.digest(string) #returns an encrypted hash via bycrypt
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	return BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token  #returns a random hash/token
    	SecureRandom.urlsafe_base64
    end

    def remember #generates a random hash and stores in database
      	self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(self.remember_token))
                                           #user digest means to encrypt
    end

    def authenticated?(attribute,token) #decrypts the attribute and returns true if both matches
    	digest = self.send("#{attribute}_digest")
    	return false if digest.nil?
    	BCrypt::Password.new(digest).is_password?(token)
    	        #password.new means to decrypt
    end

    def forget
		update_attribute(:remember_digest,nil)
	end

	def activate		
		update_columns(activated: true, activated_at: Time.zone.now)		
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def create_reset_digest
		self.reset_token = User.new_token
	 	update_columns(reset_digest: User.digest(reset_token),reset_sent_at: Time.zone.now)
	 end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now		
	end

	def password_reset_expired?
		reset_sent_at < 2.hour.ago
	end
	
	private 

	def create_activation_digest
		self.activation_token = User.new_token
		self.activation_digest = User.digest(activation_token)
	end

	def downcase_email
		return self.email.downcase!
	end
end
