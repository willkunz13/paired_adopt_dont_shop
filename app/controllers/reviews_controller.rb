class ReviewsController < ApplicationController
  def new
	
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

    pet.save

    redirect_to "/shelters/#{pet.shelter_id}/pets"
  end
end
