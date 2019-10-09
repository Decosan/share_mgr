class ReviewsController < ApplicationController
  before_action :set_review, only:[:edit, :update, :destroy]

  def index
  end

  def new
    @review = Review.new
    @assignment = Assignment.find_by(params[:id])
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      @review.assign_reviews.create(assignment_id: params[:assignment_id])
      flash[:success] ='評価を投稿しました'
      redirect_to routine_assignment_path(id: params[:assignment_id])
    else
      flash[:danger] ='失敗しました'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:warning] ='評価を編集しました'
      redirect_to routine_assignment_path(id: params[:assignment_id])
    else
      flash[:danger] ='失敗しました'
      render 'edit'
    end  
  end

  def destroy
    if @review.destroy
      flash[:danger] ='評価を削除しました'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rate, :user_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
