class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true

    return unless user.present?
    can :manage, Post, user: user

  end
end