class Flight < ApplicationRecord	
	belongs_to :departed_from, class_name: "Airport"
	belongs_to :arriving_to, class_name: "Airport"


	validates :arrival_date_time, presence: true
	validates :departure_date_time ,presence: true

	validate :arrival_should_be_before_departure

private

	def arrival_should_be_before_departure
		if self.arrival_date_time && self.arrival_date_time < self.departure_date_time
			errors.add(:arrival_date_time, "should not be greater than departure")
		end
	end
end


