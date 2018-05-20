class UsernameController < ApplicationController
  before_action :make_facebook_user_register_name, except: [:new, :create]
  before_action :redirect_if_username_exists
  before_action :redirect_if_not_valid_username, only: [:create]
  layout "devise"
  def new
  end

  def create
    return if @redirect
    current_user.name = @name
    current_user.save
    redirect_to root_path
  end

  private
    def redirect_if_username_exists
      if !current_user.name.empty?
        @redirect = true
        redirect_to root_path
      end
      @redirect = false
    end

    def redirect_if_not_valid_username
      @name = username_params[:name]
      if(@name.empty?)
        flash[:alert] = "registartion error: empty username"
      else
        flash[:alert] = "registration error: a user by that name exists" if(!User.where("name collate nocase == ?", @name).empty?)
      end
      if(!flash[:alert].nil?)
        redirect_to new_username_path
        @redirect = true
      end
      @redirect = false
    end

    def username_params
      params.permit(:name)
    end
end
