require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  context "as a visitor" do
    it "can click a link to create a pet" do
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

      visit "/shelters/#{shelter1.id}/pets"
      click_link "Create Pet"

      expect(current_path).to eq("/shelters/#{shelter1.id}/pets/new")

      fill_in 'Name', with: 'Scruffy'
      fill_in 'Description', with: 'curious'
      fill_in 'Age', with: '2'
      fill_in 'Sex', with: 'm'

      click_on 'Create Pet'

      expect(current_path).to eq("/shelters/#{shelter1.id}/pets")

      expect(page).to have_content("Scruffy")
      expect(page).to have_content("2")
      expect(page).to have_content("m")
    end
	it "can refute a false pet" do
		shelter1 = Shelter.create!(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")
	      visit "/shelters/#{shelter1.id}/pets"
		click_link "Create Pet"
	      fill_in 'Name', with: 'Scruffy'
	      fill_in 'Description', with: 'curious'
	      fill_in 'Sex', with: 'm'

	      click_on 'Create Pet'
		expect(current_path).to eq("/shelters/#{shelter1.id}/pets/new")
		expect(page).to have_content("Age can't be blank and Age is not a number")
	end
   end
end
