class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role.to_s == :admin.to_s
      can :manage, :all
    else
      can :destroy, Post do |post|
        post.try(:user) == user
      end
      can :create, Comment
      can :destroy, Comment do |comment|
        comment.try(:user) == user
      end
    end
    can :read, :all
  end
end
