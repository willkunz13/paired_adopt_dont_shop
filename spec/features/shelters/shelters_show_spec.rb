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
	it "can display shelter stats" do
		shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

		review1 = Review.create(title: "Love this shelter!",
                              rating: 5,
                              content: "I feel that this shelter has given me so many pets it should be illegal.",
                              shelter_id: shelter1.id)
		pet1 = shelter1.pets.create!(image: "https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg",
                        name: "Athena",
                        description: "butthead",
                        age: "1",
                        sex: "f",
                        adoptable: "yes",
                        shelter_id: shelter1.id
                        )
      pet2 = shelter1.pets.create!(image: "https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg",
                        name: "Odell",
                        description: "good dog",
                        age: "4",
                        sex: "m",
                        adoptable: "yes",
                        )
		    visit "/pets/#{pet1.id}"
                	click_button "Add to Favorites"
		    visit "/pets/#{pet2.id}"
               		 click_button "Add to Favorites"

		visit "/favorites"
                click_button "Apply for Pets"

                within "#pet-#{pet1.id}" do
                page.check "pets_"
                end

                fill_in 'name', with: "Bob"
                fill_in 'address', with: "123 Rainbow Road"
                fill_in 'city', with: "Boulder"
                fill_in 'state', with: "Denver"
                fill_in 'zip', with: "81125"
                fill_in 'phone', with: "616-222-8989"
                fill_in 'description', with: "I already have 14 dogs and we need to add another member to the team."

                click_button "Submit Application"

		visit "/applications/#{Application.all.first.id}"
              within "#pet-#{pet1.id}" do
               click_on "Approve"
              end

	      visit "/shelters/#{shelter1.id}"
		expect(page).to have_content("Number of Pets: 2")
		expect(page).to have_content("Review Average: 5")
		expect(page).to have_content("Applications: 1")
	end
	
	it "can delete reviews about it with it" do
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
		click_on "Delete Shelter"
		expect(Review.first).to eq(nil)
	end
  end
end
