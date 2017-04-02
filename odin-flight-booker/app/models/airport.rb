class Airport < ApplicationRecord

	has_many :departing_flights, class_name: "Flight",
	 	foreign_key: "departed_from_id", dependent: :destroy
	
	has_many :arriving_flights, class_name: "Flight",
		foreign_key: "arriving_to_id", dependent: :destroy

	validates :name, presence: true, length: {is: 3}
end
