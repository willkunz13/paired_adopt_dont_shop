require 'rails_helper'

RSpec.describe "On index page" do
  before(:each) do
          @shelter1 = Shelter.create(name: "Mike's Shelter",
                          address: "1331 17th Street",
                          city: "Denver",
                          state: "CO",
                          zip: "80202")

          @shelter2 = Shelter.create(name: "Meg's Shelter",
                          address: "150 Main Street",
                          city: "Hershey",
                          state: "PA",
                          zip: "17033")

          @pet1 = Pet.create!(image: "https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg",
                  name: "Athena",
                  description: "butthead",
                  age: "1",
                  sex: "f",
                  adoptable: "yes",
                  shelter_id: @shelter1.id)

          @pet2 = Pet.create!(image: "https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg",
                  name: "Odell",
                  description: "good dog",
                  age: "4",
                  sex: "m",
                  adoptable: "yes",
                  shelter_id: @shelter2.id)

    visit "/pets/#{@pet1.id}"
		click_button "Add to Favorites"
    visit "/pets/#{@pet2.id}"
 		click_button "Add to Favorites"
  end

    it "can apply for one favorited pet" do
      visit "/favorites"
      click_button "Apply for Pets"

      expect(current_path).to eq("/applications/new")

      within "#pet-#{@pet1.id}" do
        page.check "pets_"
      end

      fill_in 'name', with: "Bob"
      fill_in 'address', with: "123 Rainbow Road"
      fill_in 'city', with: "Boulder"
      fill_in 'state', with: "Denver"
      fill_in 'zip', with: "81125"
      fill_in 'phone', with: "616-222-8989"
      fill_in 'description[]', with: "I already have 14 dogs and we need to add another member to the team."

      click_button "Submit Application"
      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Your application has been submitted for Athena!")
      expect(page).to have_content("Favorites(1)")
      expect(page).to not_have("Age: 1")
      expect(page).to not_have("Sex: f")
    end
end
