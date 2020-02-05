class ReviewsController < ApplicationController
  def new
	@shelter_id = params[:shelter_id]	
  end

  def create
    review = Review.new(review_params)
    review.save
    redirect_to "/shelters/#{review.shelter_id}"
  end

	private

	def review_params
	      params.permit(
		:title,
		:image,
		:rating,
		:content,
		:shelter_id)
	end
end
