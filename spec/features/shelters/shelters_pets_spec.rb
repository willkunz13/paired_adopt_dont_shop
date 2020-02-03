require 'rails_helper'

RSpec.describe "shelter pets page", type: :feature do
  context "as a visitor" do
    it "can see all pets for that shelter" do
      shelter1 = Shelter.create!(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")
      shelter2 = Shelter.create!(name: "Meg's Shelter",
                                address: "150 Main Street",
                                city: "Hershey",
                                state: "PA",
                                zip: "17033")

      pet1 = shelter1.pets.create!(image: "https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg",
                        name: "Athena",
                        description: "butthead",
                        age: "1",
                        sex: "f",
                        adoptable: "yes",
                        shelter_id: shelter1.id
                        )
      pet2 = shelter2.pets.create!(image: "https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg",
                        name: "Odell",
                        description: "good dog",
                        age: "4",
                        sex: "m",
                        adoptable: "yes",
                        shelter_id: shelter2.id
                        )

      visit "/shelters/#{shelter1.id}"

      click_link "Pets"

      visit "/shelters/#{shelter1.id}/pets"

      expect(page).to have_css("img[src*='#{pet1.image}']")
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet1.age)
      expect(page).to have_content(pet1.sex)
    end
  end
end
