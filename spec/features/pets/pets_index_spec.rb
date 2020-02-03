require 'rails_helper'

RSpec.describe "pets index page", type: :feature do
  context "as a visitor" do
    it "can see all pets" do
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
                        shelter_id: shelter1.id
                        )

      pet2 = Pet.create!(image: "https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg",
                        name: "Odell",
                        description: "good dog",
                        age: "4",
                        sex: "m",
                        adoptable: "yes",
                        shelter_id: shelter2.id
                        )
      visit '/pets'

      expect(page).to have_content("Athena")
      expect(page).to have_content("Odell")
    end
  end
end

RSpec.describe "pets index page", type: :feature do
  context 'as a visitor' do
    it "can update a specific pet" do
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
                        shelter_id: shelter1.id
                        )
      pet2 = Pet.create!(image: "https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg",
                        name: "Odell",
                        description: "good dog",
                        age: "4",
                        sex: "m",
                        adoptable: "yes",
                        shelter_id: shelter2.id
                        )

      visit "/pets"
      within "#pet-#{pet1.id}" do
        click_link "Update Pet"
      end
      expect(current_path).to eq("/pets/#{pet1.id}/edit")

      fill_in 'age', with: "10"
      fill_in 'description', with: "old boy"

      click_on "Update Pet"
      expect(current_path).to eq("/pets/#{pet1.id}")
      expect(page).to have_content("10")
      expect(page).to have_content("old boy")
    end
  end
end

RSpec.describe "pets index page", type: :feature do
  context 'as a visitor' do
    it "can delete a specific pet" do
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
                        shelter_id: shelter1.id
                        )
      pet2 = Pet.create!(image: "https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg",
                        name: "Odell",
                        description: "good dog",
                        age: "4",
                        sex: "m",
                        adoptable: "yes",
                        shelter_id: shelter2.id
                        )

      visit "/pets"
      within "#pet-#{pet1.id}" do
        click_link "Delete Pet"
      end
      expect(current_path).to eq("/pets")

      expect(current_path).to eq("/pets")
      expect(page).to have_no_content(pet1)
    end
  end
end

RSpec.describe "pets index page", type: :feature do
  context 'as a visitor' do
    it "can select shelter name and go to their show page" do
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
                        shelter_id: shelter1.id
                        )
      pet2 = Pet.create!(image: "https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg",
                        name: "Odell",
                        description: "good dog",
                        age: "4",
                        sex: "m",
                        adoptable: "yes",
                        shelter_id: shelter2.id
                        )

      visit "/pets"
      within "#pet-#{pet1.id}" do
        click_link "#{pet1.shelter.name}"
      end
      expect(current_path).to eq("/shelters/#{shelter1.id}")
    end
  end
end
