class ApplicationsController < ApplicationController
  def new
	if !session[:favorites].empty?
    		@pets = Pet.find([session[:favorites]])
	else
		flash[:notice] = "No favorites"
		redirect_back(fallback_location:"/applications")
	end
  end

  def create
    application = Application.new(app_params)
    if params[:pets]
    	pets = Pet.find(params[:pets])
	application.app_pet_add(pets) 
    end
    if application.save
     params[:pets].each{|pet_id| session[:favorites].delete(pet_id)}
      flash[:notice] = "Your application has been submitted for #{application.pets.map{|pet| pet.name}.join(", ")}! "
      redirect_to "/favorites"
    else
	flash[:error] = application.errors.full_messages.to_sentence	
      redirect_back(fallback_location:"/applications/new")
    end
  end

	def show
		@application = Application.find(params[:id])
	end

	def index
		@pet = Pet.find(params[:pet_id])
	end

  def update
    app = Application.find(params[:app_id])
    if params[:pet_id]
      pet = Pet.find(params[:pet_id])
      pet.adopt_pending(app.name)
      pet.save
      redirect_to "/pets/#{pet.id}"
    elsif params[:pets]
      pets = Pet.find(params[:pets])
      pets.each do |pet| 
	if pet.adoptable == "yes"
		pet.adopt_pending(app.name)
		pet.save
	else
		flash[:notice] = "One or more selected pets already approved" 
		redirect_back(fallback_location:"/applications/new") and return
	end	
       end
	redirect_to "/applications/#{app.id}" and return
     else
	flash[:notice] = "A pet needs to be selected"
        redirect_back(fallback_location:"/applications/new") and return	
     end
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    pet.unadopt
    pet.save
    redirect_back(fallback_location:"/")
  end

  private

  def app_params
    params.permit(
        :name,
          :address,
            :city,
              :state,
                :zip,
                  :phone,
                    :description)
  end

end
