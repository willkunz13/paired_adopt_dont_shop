RSpec.describe "review edit page", type: :feature do
  context "as a visitor" do
    it "can edit a review" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      review1 = Review.create(title: "Love this shelter!",
                              rating: 5,
                              content: "I feel that this shelter has given me so many pets it should be illegal.",
                              image: "https://cdn.shopify.com/s/files/1/2336/3219/products/shutterstock_77846398eureka2_x850.jpg?v=1554665666",
                              shelter_id: shelter1.id)

      visit "/shelters/#{shelter1.id}"
            click_link "Edit Review"

            expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/#{review1.id}/edit")

            fill_in 'Title', with: 'review_test'
      fill_in 'Rating', with: '9'
      fill_in 'content', with: 'test content'

            click_button "Submit"

            expect(current_path).to eq("/shelters/#{shelter1.id}")
            expect(page).to have_content("review_test")
      expect(page).to have_content("9")
      expect(page).to have_content("test content")
    end
    it "can explain an edit error" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      review1 = Review.create(title: "Love this shelter!",
                              rating: 5,
                              content: "I feel that this shelter has given me so many pets it should be illegal.",
                              image: "https://cdn.shopify.com/s/files/1/2336/3219/products/shutterstock_77846398eureka2_x850.jpg?v=1554665666",
                              shelter_id: shelter1.id)

      visit "/shelters/#{shelter1.id}"
            click_link "Edit Review"

            expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/#{review1.id}/edit")

      fill_in 'Rating', with: '9'
      fill_in 'content', with: 'test content'

            click_button "Submit"

            expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/#{review1.id}/edit")
            expect(page).to have_content("Fields required: Title, Rating, Content")
    end
  end
end

