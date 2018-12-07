require 'rails_helper'

RSpec.describe "movies/new", type: :view do
  before(:each) do
    assign(:movie, Movie.new(
      :imdb_id => "",
      :title => "",
      :release_year => "",
      :release_date => "",
      :genre => "",
      :rating => 1
    ))
  end

  it "renders new movie form" do
    render

    assert_select "form[action=?][method=?]", movies_path, "post" do

      assert_select "input#movie_imdb_id[name=?]", "movie[imdb_id]"

      assert_select "input#movie_title[name=?]", "movie[title]"

      assert_select "input#movie_release_year[name=?]", "movie[release_year]"

      assert_select "input#movie_release_date[name=?]", "movie[release_date]"

      assert_select "input#movie_genre[name=?]", "movie[genre]"

      assert_select "input#movie_rating[name=?]", "movie[rating]"
    end
  end
end
