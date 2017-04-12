class PassengerMailer < ApplicationMailer

	def completed_booking(passenger)
		@passenger = passenger
		@booking = @passenger.booking
		@flight = @booking.flight
		mail to: @passenger.email, subject: "Successfully booked ticket!"
	end

end
