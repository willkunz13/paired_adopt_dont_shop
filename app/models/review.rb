class Review < ApplicationRecord
	validates_numericality_of :rating, greater_than: 0, less_than: 11
  validates_presence_of :title, :rating, :content
  belongs_to :shelter
end
