class Movie < ApplicationRecord

    before_save :set_slug

    has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :fans, through: :favorites, source: :user
    has_many :critics, through: :reviews, source: :user
    has_many :movie_genre_links
    has_many :genres, through: :movie_genre_links

    validates :title, :released_on, presence: true, uniqueness: true

    validates :description, length: { minimum: 25 }

    validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

    validates :image_file_name, format: {
        with: /\w+\.(jpg|png)\z/i,
        message: "must be a JPG or PNG image"
    }

    RATINGS = %w(G PG PG-13 R NC-17);
    validates :rating, inclusion: { in: RATINGS, message: "must be a JPG or PNG image" }

    scope :released, -> { Movie.where("released_on < ?", Time.now).order(released_on: :desc) }
    scope :upcoming, -> { Movie.where("released_on > ?", Time.now).order(released_on: :asc) }
    scope :recent, ->  (max=5){ released.limit(max) }
    scope :hits, -> { Movie.where("total_gross > ?", 250000) }
    scope :flops, -> { Movie.where("total_gross < ?", 250000) }

    scope :popular, -> { Movie.joins(:reviews).group('movies.id').having( 'COUNT(reviews.id) > 1' ) }

    # @posts = @posts.joins(:sec_photos).group('posts.id').having('COUNT(sec_photos.id)
    # > 2')

    # scope :hit_by_reviews, -> { Movie.joins(:reviews).where('reviews.count > ?', 50) }
    

    # scope :with_pending_posts, -> { joins(:posts).where('posts.pending = true') }
    # scope :hit_by_reviews, -> { Movie.joins(:reviews).where("SELECT COUNT(review.id) FROM reviews) > 50") }

    # where("( SELECT COUNT(containers.id) FROM containers


    # scope :hits, -> { Movie.where("total_gross > ? OR reviews.count > ?", 250000, 50) }


    # scope :hits, (lambda do
    #     if Movie.reviews.count >= 50 and Movie.reviews.average(:stars) >=4
    #         return false
    #     else
    #         total_gross < 250000000 || total_gross.blank? || total_gross.nil?
    #     end
    #   end)

    # def hits
    #     if reviews.count >= 50 and reviews.average(:stars) >=4
    #         return false
    #     else
    #         total_gross < 250000000 || total_gross.blank? || total_gross.nil?
    #     end
    # end
    

    def average_stars
        reviews.average(:stars) || 0.0
    end

    def average_stars_as_percent
        (self.average_stars * 100) / 5
    end



    def flop?
        if reviews.count >= 50 and reviews.average(:stars) >=4
            return false
        else
            total_gross < 250000000 || total_gross.blank? || total_gross.nil?
        end
        
    end

    # def to_param
    #     slug
    # end

    private



    def set_slug
        self.slug = title.parameterize
    end

end
