class MoviesController < ApplicationController
  include Pundit
  before_action :authenticate_user!, except: [:index]
  before_action :clear_hash_of_not_needed_data, only: [ :create, :update]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def search
    @movie_title = search_params[:title].titleize
    if !@movie_title.empty?
      objects = Movie.search(@movie_title)   
      json = ActiveSupport::JSON
      json_objects = objects.map do |movie|
        stringified = json.encode(movie)
        jsonized = json.decode(stringified)
        jsonized["user"] = [movie.users.first.name]
        jsonized
      end
    end
    render :json => json_objects
  end

  def index
    @movies = get_movies_from_params
  end

  def show
    @movie = Movie.find_by(id: params.require(:id))
    @owner = belongs_to_user_or_admin?(@movie)
  end

  def edit
    @movie = Movie.find_by(id: params.require(:id))
    authorize @movie
  end

  def new
    @movie = Movie.new
  end

  def update
    m = Movie.find_by(id: params.require(:id))
    authorize m
    m.update(@m_params)
    handle_movie_persistance(m, :update)
  end


  def create
    m = current_user.movies.create(@m_params)
    handle_movie_persistance(m, :create)
  end

  def destroy
    @movie = Movie.find_by(id: params.require(:id))
    authorize @movie
    @movie.delete
    redirect_to movies_path
  end

  def find_top_rating
    @movies = Movie.top_rating(find_params)
    render "index"
  end

  protected
    def movie_params
      params.require(:movie).permit(:name,
      :comment,
      :year,
      :ww_gross,
      :rt_rating,
      genres_names: [],
      directors_attributes: [ :name, :birth_date, :birth_place],
      screenwriters_attributes: [ :name, :birth_date, :birth_place],
      actors_attributes: [ :name, :birth_date, :birth_place])
    end

    def search_params
      params.permit(:title)
    end

    def user_params
      params.permit(:user_id)
    end

    def find_params
      params.require(:take)
    end

    def clear_hash_of_not_needed_data
      @m_params = movie_params
      @m_params[:genres_names].reject!{|g| g == ""}
      @m_params[:directors_attributes].delete_if { |key, attribute| attribute[:name].empty? && attribute[:birth_place].empty? && attribute[:birth_date].empty? }
      @m_params.delete(:directors_attributes) if @m_params[:directors_attributes].empty?
      @m_params[:actors_attributes].delete_if {|key, attribute| attribute[:name].empty? && attribute[:birth_place].empty? && attribute[:birth_date].empty?}
      @m_params.delete(:actors_attributes) if @m_params[:actors_attributes].empty?
      @m_params[:screenwriters_attributes].delete_if {|key, attribute| attribute[:name].empty? && attribute[:birth_place].empty? && attribute[:birth_date].empty?}
      @m_params.delete(:screenwriters_attributes) if @m_params[:screenwriters_attributes].empty?
      @m_params[:ww_gross].insert(0, "$") if !@m_params[:ww_gross].empty? && @m_params[:ww_gross].first != "$"
    end

    def handle_movie_persistance(movie, create_or_update)
      if movie.valid?
        redirect_to movie_path(movie)
      else
        flash[:alert] = movie.errors.full_messages
        create_or_update == :create ? (redirect_to new_movie_path) : (redirect_to edit_movie_path(movie.id))
      end
    end

    def get_movies_from_params
      u_params = user_params
      if u_params.has_key?(:user_id)
        user = User.find_by_slug(u_params[:user_id])
        return user.movies
      end
      return Movie.all
    end
end
