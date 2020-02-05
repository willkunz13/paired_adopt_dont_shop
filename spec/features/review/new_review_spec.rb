require 'rails_helper'

RSpec.describe "review creation page", type: :feature do
  context "as a visitor" do
    it "can create a new review" do
      shelter1 = Shelter.create(name: "Mike's Shelter",
                                address: "1331 17th Street",
                                city: "Denver",
                                state: "CO",
                                zip: "80202")

      visit "/shelters/#{shelter1.id}"
	    click_link "Add Review"

	    expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/new")

	    fill_in 'Title', with: 'review_test'
      fill_in 'Rating', with: '9'
      fill_in 'content', with: 'test content'
	    fill_in "image", with: 'https://cdn.shopify.com/s/files/1/2336/3219/products/shutterstock_77846398eureka2_x850.jpg?v=1554665666'

	    click_button "Submit"

	    expect(current_path).to eq("/shelters/#{shelter1.id}")
	    expect(page).to have_content("review_test")
      expect(page).to have_content("9")
      expect(page).to have_content("test content")
	    expect(page).to have_css("img[src*='https://cdn.shopify.com/s/files/1/2336/3219/products/shutterstock_77846398eureka2_x850.jpg?v=1554665666']")
    end
  end
end

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
  end
end
