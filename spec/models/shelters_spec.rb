require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

	describe "helper_methods" do
		it "can can count pets" do
			shelter1 = Shelter.create!(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

		      pet1 = Pet.create!(image: "https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg",
			name: "Athena",
			description: "butthead",
			age: "1",
			sex: "f",
			adoptable: "yes",
			shelter_id: shelter1.id
		      )
			expect(shelter1.pet_count).to eq(1)
		end
		
		it "can get an average of reviews" do
			shelter1 = Shelter.create!(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

			review1 = Review.create(title: "Love this shelter!",
                              rating: 5,
                              content: "I feel that this shelter has given me so many pets it should be illegal.",
                              image: "https://cdn.shopify.com/s/files/1/2336/3219/products/shutterstock_77846398eureka2_x850.jpg?v=1554665666",
                              shelter_id: shelter1.id)
			review2 = Review.create(title: "Love this shelter!",
                              rating: 1,
                              content: "I feel that this shelter has given me so many pets it should be illegal.",
                              image: "https://cdn.shopify.com/s/files/1/2336/3219/products/shutterstock_77846398eureka2_x850.jpg?v=1554665666",
                              shelter_id: shelter1.id)	
			expect(shelter1.avg_rating).to eq(3)
		end		
		
		it "can count applications" do
			shelter1 = Shelter.create!(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")
			expect(shelter1.application_count).to eq(0)
			pet1 = Pet.create!(image: "https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg",
                  name: "Athena",
                  description: "butthead",
                  age: "1",
                  sex: "f",
                  adoptable: "yes",
                  shelter_id: shelter1.id)
			shelter1.pets << pet1
			application = Application.new( name: "a", address: "a", city: "a", state: "a", zip: "1", description: "a", phone: "1")
			application.pets << pet1
			application.save
			expect(shelter1.application_count).to eq(1)
		end
	end

end
