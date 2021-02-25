class ReviewsController < ApplicationController

    before_action :set_movie
    before_action :require_signin

    def index
        @movie = Movie.find(params[:movie_id])
        @reviews = @movie.reviews
      end

    def new
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(review_params)
        @review.user = current_user
        if @review.save
            redirect_to movie_reviews_path(@movie), notice: "Review added!"
        else
            render :new
        end
    end

    def edit
        @review = Review.find(params[:id])
    end

    def update
        @review = Review.find(params[:id])
        if @review.update(review_params)     
            redirect_to movie_reviews_url, notice: "Review successfully updated"
        else
            render :edit
        end
    end

    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        redirect_to movie_reviews_url, danger: "Review successfully deleted"
    end


private

    def review_params
        params.require(:review).permit(:stars, :comment)
    end

    def set_movie
        @movie = Movie.find(params[:movie_id])
    end

end
