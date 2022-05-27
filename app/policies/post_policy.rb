class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    # all users can view posts
    true
  end

  def edit?
    record.authors.include?(user)
  end

  def update?
    record.authors.include?(user)
  end
end
