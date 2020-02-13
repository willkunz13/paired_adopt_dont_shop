class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
	validates_numericality_of :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

	def pet_count
		self.pets.size
	end
	
	def avg_rating
		if !self.reviews.empty?
			reviews = self.reviews.map {|review| review.rating.to_i}
			reviews.inject{ |sum, el| sum + el }.to_f / reviews.size
		else
			0
		end
	end

	def application_count
		apps = []
		self.pets.each do |pet|
			pet.applications.each do |app|
				apps << app
			end
		end
		apps.size
	end
end
