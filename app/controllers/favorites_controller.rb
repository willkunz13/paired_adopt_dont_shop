class FavoritesController < ApplicationController
	def update
		pet = Pet.find(params[:pet_id])
		pet_id_str = pet.id.to_s
		session[:favorites] ||= []
		if session[:favorites].include?(pet_id_str)
			flash[:notice] = "#{pet.name} is already in your favorites! Yay!!!!!"
		else
			session[:favorites] << pet_id_str 
			flash[:notice] = "You have added #{pet.name} to your favorites! Yay!!!!!"
		end
		redirect_to "/pets/#{pet.id}"
	end
end
