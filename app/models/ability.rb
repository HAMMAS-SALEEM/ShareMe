class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    end
      can :destroy, Post do |post|
        post.try(:user) == user
      end
      can :create, Comment
      can :destroy, Comment do |comment|
        comment.try(:user) == user
      end
    can :read, :all
  end
end
