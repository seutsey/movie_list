require 'rails_helper'

RSpec.describe "movies/index", type: :view do
  before(:each) do
    assign(:movies, [
      Movie.create!(
        :imdb_id => "",
        :title => "",
        :release_year => "",
        :release_date => "",
        :genre => "",
        :rating => 2
      ),
      Movie.create!(
        :imdb_id => "",
        :title => "",
        :release_year => "",
        :release_date => "",
        :genre => "",
        :rating => 2
      )
    ])
  end

  it "renders a list of movies" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 10
  end
end
