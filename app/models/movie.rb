class Movie < ActiveRecord::Base
    has_many :list_movies

    def self.omdb_api
        "http://www.omdbapi.com/?apikey=#{Rails.application.secrets.omdb_key}"
    end

    def self.omdb_poster_api
        "http://img.omdbapi.com/?apikey=#{Rails.application.secrets.omdb_key}"
    end

    def self.search(search_string)
        JSON.parse(HTTParty.get("#{Movie.omdb_api}&#{search_string}").to_s)["Search"]
    end

    def self.get_by_imdb_id(imdb_id)
        JSON.parse(HTTParty.get("#{Movie.omdb_api}&i=#{imdb_id}").to_s)
    end
end
