class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find([session[:favorites]])
  end

  def create
    application = Application.new(app_params)
    if application.save
      pets = Pet.find(params[:pets])
      application.app_pet_add(pets)
      params[:pets].each{|pet_id| session[:favorites].delete(pet_id)}
      flash[:notice] = "Your application has been submitted for #{application.pets.map{|pet| pet.name}.join(", ")}! "
      redirect_to "/favorites"
    else
      flash[:notice] = "Fields required: Name, Address, City, State, Zip, Phone Number, Description"
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
    pet = Pet.find(params[:pet_id])
    pet.adopt_pending
    pet.save
    session[:approved_name] = Application.find(params[:app_id]).name
    redirect_to "/pets/#{pet.id}"
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
