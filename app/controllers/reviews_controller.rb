class ReviewsController < ApplicationController
  def new
	  @shelter_id = params[:shelter_id]
  end

  def create
    review = Review.new(review_params)
    if review.save
	redirect_to "/shelters/#{review.shelter_id}"
    else
	flash[:error] = review.errors.full_messages.to_sentence
	redirect_to "/shelters/#{review.shelter_id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)

    if review.save
	    redirect_to "/shelters/#{review.shelter_id}"
    else
	flash[:error] = review.errors.full_messages.to_sentence
        redirect_to "/shelters/#{review.shelter_id}/reviews/#{review.id}/edit"
    end
  end

  def destroy
    shelter_id = Review.find(params[:id]).shelter.id
    Review.destroy(params[:id])
    redirect_to "/shelters/#{shelter_id}"
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
