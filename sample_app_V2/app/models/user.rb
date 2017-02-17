class User < ApplicationRecord
	attr_accessor :remember_token

	before_save {self.email.downcase!}

	validates :name,presence: true,length: {maximum: 50}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email,presence: true,length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX},
		uniqueness: {case_sensitive: false}

	validates :password, length: {in: 6..75}, presence: true

	has_secure_password

	def self.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	return BCrypt::Password.create(string, cost: cost)
    end

    def self.new_token  #returns a random hash/token
    	SecureRandom.urlsafe_base64
    end

    def remember #remembers a user in the data base
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end
end
