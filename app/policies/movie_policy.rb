class MoviePolicy < ApplicationPolicy
  def edit?
    belongs_to_user_or_admin?
  end

  def update?
    belongs_to_user_or_admin?
  end

  def destroy?
    belongs_to_user_or_admin?
  end

  private
    def belongs_to_user_or_admin?
      @record.users.include?(@user) || @user.admin?
    end
end
