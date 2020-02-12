class PetsController < ApplicationController
  def index
    if params[:shelter_id]
      @shelter = Shelter.find(params[:shelter_id])
      @pets = @shelter.pets
    else
      @pets = Pet.all
    end
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    pet = Pet.new({
      image: params[:image],
      name: params[:name],
      description: params[:description],
      age: params[:age],
      sex: params[:sex],
      adoptable: params[:adoptable],
      shelter_id: params[:shelter_id]
      })
	
    if pet.save
        redirect_to "/shelters/#{pet.shelter_id}/pets"
    else
        flash[:notice] = "Fields required: Image, Name, Description, Age, Sex"
	redirect_back(fallback_location:"/shelters")
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update({
      image: params[:image],
      name: params[:name],
      description: params[:description],
      age: params[:age],
      sex: params[:sex],
      })

    if pet.save
	redirect_to "/pets/#{pet.id}"
    else
	flash[:notice] = "Fields required: Image, Name, Description, Age, Sex"
	redirect_back(fallback_location:"/pets")
    end
  end

  def destroy
	pet = Pet.find(params[:id])
	if pet.adoptable == "yes"
	    Pet.destroy(params[:id])
		if session[:favorites]
			session[:favorites].delete(pet.id.to_s)
		end
	    redirect_to '/pets'
	else
		flash[:notice] = "Unable to delete pet with an approved application"
      redirect_back(fallback_location:"/")
	end
  end
end
