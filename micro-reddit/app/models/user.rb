class User < ApplicationRecord
	has_many :posts
	has_many :comments
	before_save {email.downcase}

	validates(:username, presence: true,length: {maximum: 20})

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates(:email, presence: true, length: {maximum: 255},
	format: {with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false})

end
