class Screenwriter < ActiveRecord::Base
  include Slugifable
  has_many :screenwriter_movies
  has_many :movies, through: :screenwriter_movies
  has_many :genres, through: :movies

  validates :name, presence: true
end
