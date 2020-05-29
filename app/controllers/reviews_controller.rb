class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_cocktail, only: [:new, :create, :update]
  
  def index
    @reviews = Review.all
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.cocktail = @cocktail
    if @review.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(@review.cocktail_id)
  end

  def update
    @review.update(review_params)

    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to cocktail_path(@review.cocktail)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def set_cocktail
    @cocktail = Cocktail.find(@review.cocktail_id)
  end
end
