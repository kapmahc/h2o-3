class LeaveWordPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    !user.nil? && user.is_admin?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def destroy?
    index?
  end


end
