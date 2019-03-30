class EventPolicy < ApplicationPolicy

  def new?
    @user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
