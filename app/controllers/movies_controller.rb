class MoviesController < ApplicationController

    before_action :require_signin, except: [:index, :show]
    before_action :require_admin_user, except: [:index, :show]
    before_action :set_movie, only: [:show, :edit, :update, ]

    def index
        case params[:filter]
            when "upcoming"
                @movies = Movie.upcoming
            when "recent"
                @movies = Movie.recent
            when "hits"
                @movies = Movie.hits   
            when "flops"
                @movies = Movie.flops
                
            else
            @movies = Movie.released
        end
    end

    def show
        # @movie = Movie.find_by!(slug: params[:id])
        @review = @movie.reviews.new
        @fans = @movie.fans
        if current_user
            @favorite = current_user.favorites.find_by(movie: @movie)
        end
        @genres = @movie.genres
    end

    def edit
        # @movie = Movie.find(params[:id])
    end

    def update
    
        # @movie = Movie.find(params[:id])
        if @movie.update(movie_params)     
            redirect_to @movie, notice: "Movie successfully updated"
        else
            render :edit
        end
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to @movie, notice: "Movie successfully added"
        else
            render :new
        end
    end

    def destroy
        # @movie = Movie.find(params[:id])
        @movie.destroy
        redirect_to movies_url, danger: "Movie successfully deleted"
    end


private

    def movie_params
        params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, 
                                        :director, :duration, :image_file_name, genre_ids:[])
    end

    def set_movie
        @movie = Movie.find(params[:id])
    end

end
