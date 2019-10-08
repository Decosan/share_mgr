class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] ='評価を投稿しました'
      redirect_to reviews_path
    else
      flash[:danger] ='失敗しました'
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:content, :rate, :user_id)
  end
end
