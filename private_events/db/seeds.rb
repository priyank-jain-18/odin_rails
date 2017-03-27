# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(username:  "tester123",
             email: "tester@gmail.com",
             password: "tester123",
             password_confirmation: "tester123") 

99.times do |n|
	username = "testuser#{n}"
	email = Faker::Internet.unique.email
	password = "tester123"

	User.create!(username: username,
                 email: email,
      	         password: password,
                 password_confirmation: password)

end

users = User.take(99)

2.times do #generate random events 2 for each user
	#event deteails
    content = Faker::Lorem.sentence(5)
    title = Faker::Name.unique.title[0..24] #characters limit to 30
    random_time = Faker::Time.unique.between(1.year.ago, 1.year.from_now, :all)
    
    users.each do |user| 
        event = user.events.create!(title: title, description: content, event_start_date: random_time) 
        6.times do #invitations for each event is 30
        	#attendee details
        	freed_user_ids = (1..99).to_a #unique array list
        	freed_user_ids.delete(user.id)
        	random_user = User.find(freed_user_ids.delete(freed_user_ids.sample)) #finds random unique user
        	random_boolean = [true, false].sample          	

        	event.attendees.create!(invited_user: random_user.username, accepted: random_boolean)
        end
    end    
end