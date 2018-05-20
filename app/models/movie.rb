class Movie < ActiveRecord::Base
  include Slugifable
  has_many :actor_movies
  has_many :director_movies
  has_many :screenwriter_movies
  has_many :genre_movies
  has_many :user_movies
  has_many :users, through: :user_movies
  has_many :actors, through: :actor_movies
  has_many :directors, through: :director_movies
  has_many :genres, through: :genre_movies
  has_many :screenwriters, through: :screenwriter_movies

  validates :name, presence: true
  validates :genres, presence: true

  scope :top_rating, ( -> (limit) { order(rt_rating: :desc).take(limit) } )
  scope :search, ( -> (title) { where("name LIKE ?", "%#{title}%") })

  def self.percentage_to_number_of_movies(percentage)
    num = all.size.to_f * (percentage.to_f / 100.to_f)
    num = 1 if num > 0 && num < 1
    num.to_i
  end

  def self.build_attributes_for(*arg)
    arg.each do |model_association|
      define_method "#{model_association}_attributes=" do |attributes|
        attributes.each do |key, hash_attributes|
          if attributes == nil || attributes == []
            self.send("#{model_association}=", attributes)
          elsif(self.send("#{model_association}")[key.to_i].nil?)
            self.send("#{model_association}").build(hash_attributes)
          else
            self.send("#{model_association}")[key.to_i].update(hash_attributes)
          end
        end
      end
    end
  end

  build_attributes_for :directors, :screenwriters, :actors

  def genres_names=(names)
    self.genres = []
    names.each do |name|
      g = Genre.find_or_create_by(name: name)
      self.genres.concat(g)
    end
  end

  def genres_names
    self.genres.map{|g| g.name}
  end

end
