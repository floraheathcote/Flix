class Genre < ApplicationRecord

    validates :name, presence: true, uniqueness: { case_sensitive: false }
    has_many :movie_genre_links
    has_many :movies, through: :movie_genre_links

end
