class List < ActiveRecord::Base
    has_many :list_movies
    has_many :movies, through: :list

    def average_rating
        rating_total = 0
        self.list_movies.each { |list_movie| rating_total += list_movie.movie.rating || 0 }
        rating_total / self.list_movies.count
    end
end
