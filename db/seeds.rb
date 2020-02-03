Pet.destroy_all
Shelter.destroy_all

shelter1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")
shelter2 = Shelter.create(name: "Meg's Shelter", address: "150 Main Street", city: "Hershey", state: "PA", zip: "17033")
pet1 = Pet.create(image: "https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg",
                  name: "Athena",
                  description: "butthead",
                  age: "1",
                  sex: "f",
                  adoptable: "yes",
                  shelter_id: shelter1.id
                  )
pet2 = Pet.create(image: "https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg",
                  name: "Odell",
                  description: "good dog",
                  age: "4",
                  sex: "m",
                  adoptable: "yes",
                  shelter_id: shelter2.id
                  )
