class CreateMovieGenreLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_genre_links do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
