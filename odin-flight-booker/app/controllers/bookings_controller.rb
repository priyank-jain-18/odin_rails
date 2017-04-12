class BookingsController < ApplicationController
before_action :check_if_there_are_params, only: :new
before_action :check_if_valid_params, only: :new
before_action :check_if_valid_flight, only: :create

	def new
		@flight = Flight.find(params[:flight_id])
		@booking = Booking.new(flight: @flight)		
		params[:number_of_passengers].to_i.times {@booking.passengers.build}
	end

	def create
		flight_id = booking_params[:flight_id]
		number_of_passengers = booking_params.to_h[:passengers_attributes].count
		booking = Booking.new(flight_id: booking_params[:flight_id])
		if booking.save && !( number_of_passengers > 4)			
			booking_params.to_h[:passengers_attributes].each do |key,value|
				passenger = booking.passengers.build(name: value["name"], email: value["email"])
				if !passenger.save
					booking.destroy
					flash[:danger] = "invalid user info"
					redirect_to new_booking_path(flight_id: flight_id,
						number_of_passengers: number_of_passengers) and return
				end						
			end
			mail_booking_passengers(booking)
			redirect_to booking_path(booking)
		else
			redirect_to new_booking_path(flight_id: flight_id,
				number_of_passengers: number_of_passengers) and return
		end
	end	

	def show
		@booking = Booking.find(params[:id])
		@flight = @booking.flight
	end

	private

	def check_if_valid_flight
		unless Flight.find_by(id: booking_params[:flight_id]).present?
			flash[:danger] = "invalid flight id"
			redirect_to root_url
		end
	end

	def booking_params
		params.require(:booking).permit(:flight_id,passengers_attributes: [:name, :email])
	end

	def check_if_there_are_params 
		redirect_to root_url if params[:flight_id].nil? || params[:number_of_passengers].nil?
	end

	def check_if_valid_params
		redirect_to root_url if Flight.find_by(id: params[:flight_id]).nil? ||
			(params[:number_of_passengers].to_i > 4 || params[:number_of_passengers].to_i < 1)
	end

	def mail_booking_passengers(booking)
		booking.passengers.each do |passenger| 
			PassengerMailer.completed_booking(passenger).deliver_now
		end
	end

end
