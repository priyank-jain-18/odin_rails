# Preview all emails at http://localhost:3000/rails/mailers/passenger_mailer
class PassengerMailerPreview < ActionMailer::Preview

# http://localhost:3000/rails/mailers/passenger_mailer/completed_booking
	def completed_booking
		passenger = Passenger.first
		PassengerMailer.completed_booking(passenger)
	end

end
