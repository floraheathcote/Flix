module MoviesHelper

    def main_image(movie)
        if movie.main_image.attached?
            image_tag movie.main_image.variant(resize_to_limit: [150, nil])
        else
            image_tag "placeholder.png"
        end
    end

    def short_description(movie)
        truncate(movie.description, length:40, separator: " ")
    end

    def total_gross(movie)
        if movie.flop?
            "Flop!"
        else
            number_to_human( movie.total_gross, precision:0, unit:"£")
        end
    end

    def year_of(movie)
        movie.released_on.year
    end

    def display_stars_for_movie(movie)
        render "shared/stars", percent: movie.average_stars_as_percent 
    end

    def display_review_count_for_movie(movie)
        link_text = pluralize(movie.reviews.count, 'review')
        link_to link_text, movie_reviews_path(movie)
    end


    # def average_stars(movie)
    #     if movie.average_stars.zero?
    #         # content_tag(:strong, "No reviews")
    #     else
    #         ave_stars = number_with_precision(movie.average_stars, precision: 1, strip_insignificant_zeros: true)
    #         # pluralize("*" * ave_stars.to_i, "star")
            
            
    #     end
    # end

    def nav_link_to(link_text, link)
       if current_page?(link)
            link_to link_text, link, class: "active"
        else
          link_to link_text, link
      end
    end


end
