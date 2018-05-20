class ScreenwritersController < ApplicationController
  include MemberMethods
  before_action :make_facebook_user_register_name
  before_action :authenticate_user!

  def new
    member_hash = new_member(:screenwriter)
    @movie = member_hash[:movie]
    @screenwriter = member_hash[:member]
  end

  def create
    create_member(:screenwriter)
  end

  def destroy
    destroy_member(:screenwriter)
  end
end
