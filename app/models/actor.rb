class Actor < ActiveRecord::Base
  include Slugifable
  has_many :actor_movies
  has_many :movies, through: :actor_movies
  has_many :directors, through: :movies
  has_many :genres, through: :movies

  validates :name, presence: true
end
