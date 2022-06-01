class ShipmentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user.aidpioneer?
  end

  def show?
    user.aidpioneer?
  end
end
