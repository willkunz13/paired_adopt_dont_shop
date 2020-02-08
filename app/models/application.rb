class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates_presence_of :name, :address, :city, :state, :zip, :description, :phone

  def app_pet_add(pets)
    pets.each {|pet| self.pets << pet}
  end
end
