class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :year
      t.string :ww_gross
      t.integer :rt_rating
    end
  end
end
