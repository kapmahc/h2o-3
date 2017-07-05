module Forum
  class TagPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      create?
    end

    def create?
      !user.nil? && user.is_admin?
    end

    def new?
      create?
    end

    def edit?
      create?
    end

    def update?
      create?
    end

    def destroy?
      create?
    end


  end
end
