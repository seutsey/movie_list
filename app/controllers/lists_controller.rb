class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :get_lists, only: [:index, :edit, :search]
  before_action :set_search
  before_action :star_list

  # GET /lists
  # GET /lists.json
  def index
    @page_source = 'index'
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @page_source = 'show'
    @list_movies = List.find(list_id).list_movies
  end

  # GET /lists/new
  def new
    @page_source = 'new'
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
    @page_source = 'edit'
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
    @page_source = 'create'
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    @page_source = 'update'
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # @GET /lists/search
  def search
    @page_source = search_params[:source_page]
    @list = List.find(search_params[:list_id])
    @list_movies = @list.list_movies
    search_string = search_params.map { |k, v| "#{k}=#{v}" unless v.blank? || k == 'list_id' }.compact.join('&')
    @movies = Movie.search(search_string)
    render search_params[:source_page]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    def get_lists
      @lists = List.all
    end

    def list_params
      params.require(:list).permit(:name)
    end

    def list_id
      params.permit(:id)[:id]
    end

    def search_params
      params.permit(:list_id, :y, :i, :s, :source_page)
    end

    def set_search
      @search_path = list_search_path
    end

    def star_list
      @star_list = RatingScale.all.map {|st| [" * " * st.stars, st.id]}
    end
end
