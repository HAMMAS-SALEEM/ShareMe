class Ability
  include CanCan::Ability

  # def initialize(user)
  #   user ||= User.new

  #   can :manage, :all if user.is? :admin
  #   if user.role == 'author'
  #     can :destroy, Post do |post|
  #       post.try(:user) == user
  #       can :manage, :all
  #     end
  #     can :create, Comment
  #     can :destroy, Comment do |comment|
  #       comment.try(:user) == user
  #     end
  #   end
  #   can :read, :all
  # end

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all
    if user.admin?
      can :manage, :all
    else
      can :manage, Post, user_id: user.id
      can :manage, Comment, user_id: user.id
      can :read, :all
    end
  end
end
