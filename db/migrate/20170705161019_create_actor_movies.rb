class CreateActorMovies < ActiveRecord::Migration
  def change
    create_table :actor_movies do |t|
      t.integer :actor_id
      t.integer :movie_id
    end
  end
end
