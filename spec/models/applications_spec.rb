require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :description}
    it {should validate_presence_of :phone}
  end

  describe "relationships" do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  context "app_pet_add" do
    it "can add pets to application" do

    shelter1 = Shelter.create(name: "Mike's Shelter",
                    address: "1331 17th Street",
                    city: "Denver",
                    state: "CO",
                    zip: "80202")

    shelter2 = Shelter.create(name: "Meg's Shelter",
                    address: "150 Main Street",
                    city: "Hershey",
                    state: "PA",
                    zip: "17033")

    pet1 = Pet.create!(image: "https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg",
            name: "Athena",
            description: "butthead",
            age: "1",
            sex: "f",
            adoptable: "yes",
            shelter_id: shelter1.id)

    pet2 = Pet.create!(image: "https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg",
            name: "Odell",
            description: "good dog",
            age: "4",
            sex: "m",
            adoptable: "yes",
            shelter_id: shelter2.id)

    pets = [pet1, pet2]

    application1 = Application.create!(name: "a", address: "b", city: "c", state: "d", zip: "e", description: "z", phone:"y")
    application1.app_pet_add(pets)

    expect(application1.pets.size).to eq(2)
  end
  end
end
