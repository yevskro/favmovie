class AddCommentsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :comment, :string
  end
end
