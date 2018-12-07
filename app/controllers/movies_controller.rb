class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
  end

  # GET /movies/1/edit
  def edit
  end

  def rating
    redirect_to list_path(List.find(rating_params[:id]))
  end

  def add_to_list
    @list = List.find(movie_params[:list_id])
    movie_details = Movie.get_by_imdb_id(movie_params[:imdb_id])

    @movie = Movie.find_or_create_by(imdb_id: movie_details['imdbID'], title: movie_details['Title'], release_year: movie_details['Year'],
                                     release_date: Date.parse(movie_details['Released']), genre: movie_details['Genre'])

    ListMovie.find_or_create_by(list_id: @list.id, movie_id: @movie.id)

    render :show
  end

  # @GET /movies/search
  def search
    @list = List.find(search_params[:list_id])
    search_string = search_params.map { |k, v| "#{k}=#{v}" unless v.blank? || k == 'list_id' }.compact.join('&')
    @movies = Movie.search(search_string)

    render search_params[:source_page] == "search" ? Rails.application.routes.recognize_path(request.referrer)[:action] : search_params[:source_page]
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    search_string = ""

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update_attributes(rating: movie_params[:movie][:rating])
        format.html { redirect_to List.find(movie_params[:movie][:list_id]), notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.permit(:i, :t, :y, :s, :list_id, :source_page)
    end

    def movie_params
      params.permit!
    end

    def rating_params
      params.permit(:id)
    end

    def set_search
      @search_path = movie_search_path
    end
end
