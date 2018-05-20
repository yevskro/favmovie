class UsersController < ApplicationController
  include Pundit
  before_action :make_facebook_user_register_name
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def show
    redirect_to user_movies_path(id_params)
  end

  def index
    authorize current_user
    @users = User.all
  end

  def update
    authorize current_user
    user = User.find_by(id: id_params)
    user.role = user_params[:role]
    user.save
    redirect_to request.referrer
  end

  def destroy
    authorize current_user
    user = User.find_by(id: id_params)
    destroy_user(user)
    redirect_to request.referrer
  end

  private
    def id_params
      params.require(:id)
    end

    def user_params
      params.require(:user).permit(:role)
    end

    def user_not_authorized
      flash[:alert] = "Access Denied"
      redirect_to root_path
    end

    def destroy_user(user)
      user.movies.each do |movie|
        movie.screenwriters.each do |screenwriter|
          screenwriter.delete
        end
        movie.directors.each do |director|
          director.delete
        end
        movie.actors.each do |actor|
          actor.delete
        end
        movie.delete
      end
      user.delete
    end
end
