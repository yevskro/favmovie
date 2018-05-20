class UserPolicy < ApplicationPolicy
  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def index?
    admin?
  end

  private

    def admin?
      @user.admin?
    end
end
