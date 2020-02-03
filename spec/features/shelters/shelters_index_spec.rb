require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  context "as a visitor" do
    it "can see the names of all shelters" do
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

      visit "/shelters"

      expect(page).to have_content(shelter1.name)
      expect(page).to have_content(shelter2.name)
    end
  end
end
RSpec.describe "shelters index page", type: :feature do
  context "as a visitor" do
    it "can create a new shelter" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      visit "/shelters"
      click_link "New Shelter"

      expect(current_path).to eq("/shelters/new")
      expect(page).to have_content("Create New Shelter")

      fill_in 'Name', with: 'Matts DoggyDayCare'
      fill_in 'Address', with: '123 Sunny Lane'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip', with: '80205'

      click_on "Create Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to have_content("Matts DoggyDayCare")
    end
  end
end

RSpec.describe "shelters index page", type: :feature do
  context "as a visitor" do
    it "can edit a shelter" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      visit "/shelters"
      click_link "Update Shelter"

      expect(current_path).to eq("/shelters/#{shelter1.id}/edit")
      expect(page).to have_content("Edit Shelter")

      fill_in 'Name', with: 'Matts DoggyDayCare'

      click_on "Save Changes"

      expect(current_path).to eq("/shelters/#{shelter1.id}")
      expect(page).to have_content("Matts DoggyDayCare")
    end
  end
end

RSpec.describe "shelters index page", type: :feature do
  context "as a visitor" do
    it "can delete a shelter" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      visit "/shelters"
      click_link "Delete Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to have_no_content(shelter1.name)
    end
  end
end
