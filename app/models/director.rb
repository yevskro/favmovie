class Director < ActiveRecord::Base
  include Slugifable
  has_many :director_movies
  has_many :movies, through: :director_movies
  has_many :actors, through: :movies
  has_many :genres, through: :movies

  validates :name, presence: true
end
