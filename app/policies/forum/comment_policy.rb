module Forum
  class CommentPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      create?
    end

    def create?
      !user.nil?
    end

    def new?
      create?
    end

    def edit?
      update?
    end

    def update?
      create? && (record.user_id == user.id || user.is_admin?)
    end

    def destroy?
      update?
    end


  end
end
