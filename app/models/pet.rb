class Pet < ApplicationRecord
  validates_presence_of  :name, :age, :sex, :description
	validates_numericality_of :age, greater_than: 0, less_than: 30
  belongs_to :shelter
	has_many :application_pets, dependent: :destroy
	has_many :applications, through: :application_pets, dependent: :destroy

  def adopt_pending(name)
    self.adoptable = name
  end

  def unadopt
    self.adoptable = "yes"
  end
end
