class User < ApplicationRecord
	attr_accessor :remember_token

	before_save {self.email.downcase!}

	validates :name,presence: true,length: {maximum: 50}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email,presence: true,length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX},
		uniqueness: {case_sensitive: false}

	validates :password, length: {in: 6..75}, presence: true, allow_nil: true
	has_secure_password

	def User.digest(string) #returns an encrypted hash via bycrypt
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	return BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token  #returns a random hash/token
    	SecureRandom.urlsafe_base64
    end

    def remember #remembers a user in the data base
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(self.remember_token))
                                           #user digest means to encrypt
    end

    def authenticated?(remember_token) #returns true if both matches
    	return false if remember_digest.nil?
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
    	        #password.new means to decrypt
    end

    def forget
		update_attribute(:remember_digest,nil)
	end
end
