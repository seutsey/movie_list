json.extract! movie, :id, :imdb_id, :title, :release_year, :release_date, :genre, :rating, :created_at, :updated_at
json.url movie_url(movie, format: :json)
