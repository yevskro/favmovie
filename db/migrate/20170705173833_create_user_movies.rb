class CreateUserMovies < ActiveRecord::Migration
  def change
    create_table :user_movies do |t|
      t.integer :user_id
      t.integer :movie_id
    end
  end
end
