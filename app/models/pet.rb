class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :description, :adoptable
  belongs_to :shelter
end
