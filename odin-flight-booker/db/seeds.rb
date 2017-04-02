# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Airports
4.times do #creates 4 airports
	airport_name = Faker::Lorem.unique.characters(3)
	Airport.create!(name: airport_name)
end

## Flights
from_airports = Airport.all[0..1]
to_airports = Airport.all[2..3]

time_departed_from_airport = Time.zone.now + 3.hours
arrival_to_next_airport = time_departed_from_airport + 7.hours

from_airports.each_with_index do |from_airport,index| #create 4 flights with half of airports going to the other half
	from_airport.departing_flights.create!(arriving_to: to_airports[index],
		departure_date_time:  time_departed_from_airport,
		arrival_date_time: arrival_to_next_airport)
end

		
		


	

