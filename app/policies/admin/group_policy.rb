module Admin
  class GroupPolicy < Admin::AdminPolicy

    class Scope < Scope
      def resolve
        self.joins(:session, :event)
      end
    end
  end
end
