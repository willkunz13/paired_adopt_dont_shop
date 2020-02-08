class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find([session[:favorites]])
  end

  def create
    application = Application.new(app_params)
    application.save
    pet_names = application.pets
    flash[:notice] = "Your application has been submitted for "

    redirect_to "/favorites"
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
                    :description,
                      :pets)
  end
end
