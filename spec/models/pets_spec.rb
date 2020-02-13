require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end

	it "It can change adoptable status to and fro" do
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
		
		expect(pet1.adopt_pending("Bob")).to eq("Bob")
		expect(pet1.unadopt).to eq("yes")
	end
end

