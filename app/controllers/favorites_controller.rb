class FavoritesController < ApplicationController

    before_action :require_signin 
    before_action :find_movie

    def create
        # @movie.favorites.create!(user: current_user)
        @movie.fans << current_user
        redirect_to @movie
    end

    def destroy
        favorite = current_user.favorites.find(params[:id])
        favorite.destroy
        redirect_to @movie
    end

private

def find_movie
    @movie = Movie.find(params[:id])
end


end