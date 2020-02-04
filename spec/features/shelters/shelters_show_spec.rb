require 'rails_helper'

RSpec.describe "shelters/:id show page", type: :feature do
  context "as a visitor" do
    it "can show a shelter by id" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content(shelter1.name)
      expect(page).to have_content(shelter1.address)
      expect(page).to have_content(shelter1.city)
      expect(page).to have_content(shelter1.state)
      expect(page).to have_content(shelter1.zip)
    end
  end
end

RSpec.describe "shelters/:id/edit show page", type: :feature do
  context "as a visitor" do
    it "when I visit a shelter show page" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content(shelter1.name)

      click_link "Update Shelter"
      expect(current_path).to eq("/shelters/#{shelter1.id}/edit")

      fill_in 'Zip', with: '12345'
      click_on "Save Changes"

      expect(page).to have_content("12345")
    end
  end
end

RSpec.describe "shelters/:id show page", type: :feature do
  context "as a visitor" do
    it "when I visit a shelter show pageto delete the shelter" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      visit "/shelters/#{shelter1.id}"
      expect(page).to have_content(shelter1.name)

      click_on "Delete Shelter"
      expect(current_path).to eq("/shelters")
      expect(page).to have_no_content(shelter1.name)
    end
  end
end

RSpec.describe "shelters show page", type: :feature do
  context "as a visitor" do
    it "when I visit a shelter show page I see a list of reviews" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      review1 = Review.create(title: "Love this shelter!",
                              rating: 5,
                              content: "I feel that this shelter has given me so many pets it should be illegal.",
                              shelter_id: shelter1.id)

      visit "/shelters/#{shelter1.id}"
      expect(page).to have_content(review1.title)
      expect(page).to have_content(review1.rating)
      expect(page).to have_content(review1.content)

    end
  end
end
