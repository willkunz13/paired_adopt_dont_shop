class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :description, :adoptable
  belongs_to :shelter
	has_many :application_pets
	has_many :applications, through: :application_pets

  def adopt_pending(name)
    self.adoptable = name
  end

  def unadopt
    self.adoptable = "yes"
  end
end
