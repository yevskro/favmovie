class ActorsController < ApplicationController
  include MemberMethods
  before_action :make_facebook_user_register_name
  before_action :authenticate_user!

  def new
    member_hash = new_member(:actor)
    @movie = member_hash[:movie]
    @actor = member_hash[:member]
  end

  def create
    create_member(:actor)
  end

  def destroy
    destroy_member(:actor)
  end
end
