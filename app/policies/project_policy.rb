class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.donor?
        scope.where(user: user)
      else
        scope.all
      end
    end
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end
end
