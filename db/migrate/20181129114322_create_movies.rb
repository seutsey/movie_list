class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :imdb_id
      t.string :title
      t.string :release_year
      t.date :release_date
      t.string :genre
      t.integer :rating

      t.timestamps null: false
    end
  end
end
