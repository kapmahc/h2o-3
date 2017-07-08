module Mall
  class StorePolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      create?
    end

    def create?
      !user.nil? && user.has_role?(:member)
    end

    def new?
      create?
    end

    def edit?
      update?
    end

    def update?
      !user.nil? && (user.has_role? :manager, record)
    end

    def destroy?
      update?
    end

    def sell?
      !user.nil? && (user.has_role? :seller, record)
    end


  end
end
