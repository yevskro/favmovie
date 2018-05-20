class Genre < ActiveRecord::Base
  include Slugifable
  has_many :genre_movies
  has_many :movies, through: :genre_movies
  has_many :directors, through: :movies
  has_many :screenwriters, through: :movies
  has_many :actors, through: :movies

  validates :name, presence: true
end
