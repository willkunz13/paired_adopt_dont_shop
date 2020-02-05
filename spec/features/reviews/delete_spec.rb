RSpec.describe "delete review", type: :feature do
  context "as a visitor" do
    it "can delete a review" do
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

            click_link "Delete Review"

      expect(current_path).to eq("/shelters/#{shelter1.id}")
      expect(page).to have_no_content(review1.title)
      expect(page).to have_no_content(review1.rating)
      expect(page).to have_no_content(review1.content)
    end
  end
end
