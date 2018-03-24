class ReviewsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find(params[:user_id])
    @review = @user.reviews.new(review_params)
    @review.reviewing_user_id = current_user.id
    
    if @review.save
      @traid = Traid.find_by(key: params[:review][:traid_key], user_id: current_user.id)
      @traid.is_reviewable_by_user = false
      @traid.save
    else
      flash[:review] = "There was a problem posting your review, please try again."
    end
    
    redirect_to @user
  end
  
  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:text, :rating, :user_id, :traid_key)
  end
end
