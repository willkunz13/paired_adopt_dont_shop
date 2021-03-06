class FavoritesController < ApplicationController
	def update
		pet = Pet.find(params[:pet_id])
		pet_id_str = pet.id.to_s
		session[:favorites] ||= []
		session[:favorites] << pet_id_str
		flash[:notice] = "You have added #{pet.name} to your favorites! Yay!!!!!"
		redirect_to "/pets/#{pet.id}"
	end

	def index
		if !session[:favorites]
			@pets = 0
		elsif session[:favorites].empty?
			@pets = 0
		else
			@pets = Pet.find([session[:favorites]])
		end
		@application_pets = ApplicationPet.all.map {|pet_app| pet_app.pet}.uniq
	end

	 def destroy
	    pet = Pet.find(params[:id])
		pet_id = pet.id.to_s
    		session[:favorites].delete(pet_id)
				flash[:notice] = "You have removed #{pet.name} from your favorites."
		redirect_back(fallback_location:"/pets")
  	end

		def destroy_all
			session[:favorites] = []
			@pets = 0
			redirect_back(fallback_location:"/favorites")
		end

end
