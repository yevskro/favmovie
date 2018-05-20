class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :make_facebook_user_register_name
  before_action :authenticate_user!
  helper_method :belongs_to_user_or_admin?

  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end

  def make_facebook_user_register_name
    if !current_user.nil? && current_user.name.empty?
      flash[:alert] = "register a username with us! :)"
      redirect_to new_username_path
    end
  end

  def user_not_authorized
    flash[:alert] = "Access Denied"
    redirect_to (request.referrer || movies_path)
  end

  def belongs_to_user_or_admin?(movie)
    !@current_user.nil? && (movie.users.include?(@current_user) || @current_user.admin?)
  end
end
