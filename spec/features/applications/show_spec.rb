require 'rails_helper'

RSpec.describe "On show page" do
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

	it "can display application info" do
		visit "/favorites"
	      click_button "Apply for Pets"

	      within "#pet-#{@pet1.id}" do
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
		expect(page).to have_content("Name: Bob")
		expect(page).to have_content("Address: 123 Rainbow Road")
		expect(page).to have_content("City: Boulder")
		expect(page).to have_content("State: Denver")
		expect(page).to have_content("\nPets:\nAthena")
		click_on "Athena"
		expect(current_path).to eq("/pets/#{@pet1.id}")
	end

	it "can link applications from pet show page" do
		visit "/favorites"
	      click_button "Apply for Pets"

	      within "#pet-#{@pet1.id}" do
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
		visit "/pets/#{@pet1.id}"
		within "#applications" do
			click_on "View All Applications"
		end
		expect(current_path).to eq("/pets/#{@pet1.id}/applications")
		click_on "Bob"
		expect(current_path).to eq("/applications/#{Application.all.first.id}")
	end

	it "can catch empty applications page" do
		visit "/pets/#{@pet1.id}"
		within "#applications" do
			click_on "View All Applications"
		end
		expect(current_path).to eq("/pets/#{@pet1.id}/applications")
		expect(page).to_not have_content("Bob")
		expect(page).to have_content("There are no applications")
	end

   it "can approve an application" do
     visit "/favorites"
         click_button "Apply for Pets"

         within "#pet-#{@pet1.id}" do
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
         within "#pet-#{@pet1.id}" do
          click_on "Approve"
         end

         expect(current_path).to eq("/pets/#{@pet1.id}")

         expect(page).to have_content("Adoptable: Pending")
         expect(page).to have_content("On hold for: Bob")
   end

   # user story 23
   it "can approve many applications" do
     visit "/favorites"
        click_button "Apply for Pets"

        within "#pet-#{@pet1.id}" do
          page.check "pets_"
        end

        within "#pet-#{@pet2.id}" do
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

        within "#pet-#{@pet1.id}" do
          page.check "pets_"
        end

        within "#pet-#{@pet2.id}" do
          page.check "pets_"
        end

        click_button "Approve all selected"

        visit "/pets/#{@pet1.id}"
        expect(page).to have_content("Adoptable: Pending")
        expect(page).to have_content("On hold for: Bob")

        visit "/pets/#{@pet2.id}"
        expect(page).to have_content("Adoptable: Pending")
        expect(page).to have_content("On hold for: Bob")
      end

    it "pet can only have one approved application at a time" do

      visit "/favorites"
          click_button "Apply for Pets"

          within "#pet-#{@pet1.id}" do
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
          within "#pet-#{@pet1.id}" do
           click_on "Approve"
          end

          visit "/pets/#{@pet1.id}"
                      click_button "Add to Favorites"

          visit "/favorites"
            click_button "Apply for Pets"

          within "#pet-#{@pet1.id}" do
            page.check "pets_"
          end

          fill_in 'name', with: "Sandy"
          fill_in 'address', with: "123 Rainbow Road"
          fill_in 'city', with: "Boulder"
          fill_in 'state', with: "Denver"
          fill_in 'zip', with: "81125"
          fill_in 'phone', with: "616-222-8989"
          fill_in 'description', with: "I already have 14 dogs and we need to add another member to the team."

          click_button "Submit Application"

          visit "/applications/#{Application.all.first.id}"
          within "#pet-#{@pet1.id}" do
            expect(page).to_not have_content("Approve")
          end
        end

    it "can revoke an approved application" do

      visit "/favorites"
          click_button "Apply for Pets"

          within "#pet-#{@pet1.id}" do
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
          within "#pet-#{@pet1.id}" do
           click_on "Approve"
          end

          visit "/applications/#{Application.all.first.id}"
          within "#pet-#{@pet1.id}" do
            expect(page).to_not have_content("Approve")
            click_on "Unapprove"
          end

          expect(current_path).to eq("/applications/#{Application.all.first.id}")
          within "#pet-#{@pet1.id}" do
           expect(page).to have_content("Approve")
          end

          visit "/pets/#{@pet1.id}"
          expect(page).to have_content("Adoptable: yes")
          expect(page).to_not have_content("On hold for: Bob")
        end
end
