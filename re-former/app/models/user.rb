class User < ApplicationRecord
	before_save {email.downcase}
	validates(:username, presence: true,length: {maximum: 24})

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates(:email, presence: true, length: {maximum: 255},
		format: {with: EMAIL_REGEX},
		uniqueness: {case_sensitivity: false} )

	has_secure_password
	validates(:password,length {minimum: 6}, presence: true)


end
