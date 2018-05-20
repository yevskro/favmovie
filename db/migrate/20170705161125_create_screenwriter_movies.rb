class CreateScreenwriterMovies < ActiveRecord::Migration
  def change
    create_table :screenwriter_movies do |t|
      t.integer :screenwriter_id
      t.integer :movie_id
    end
  end
end
