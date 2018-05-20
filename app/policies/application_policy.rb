class ApplicationPolicy
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @user = current_user
    @record = record
  end
end
