class DirectorsController < ApplicationController
  include MemberMethods
  before_action :make_facebook_user_register_name
  before_action :authenticate_user!

  def new
    member_hash = new_member(:director)
    @movie = member_hash[:movie]
    @director = member_hash[:member]
  end

  def create
    create_member(:director)
  end

  def destroy
    destroy_member(:director)
  end
end
