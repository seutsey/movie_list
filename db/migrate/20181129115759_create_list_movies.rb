class CreateListMovies < ActiveRecord::Migration
  def change
    create_table :list_movies do |t|
      t.integer :list_id
      t.integer :movie_id

      t.timestamps null: false
    end
  end
end
