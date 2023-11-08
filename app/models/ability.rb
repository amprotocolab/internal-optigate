class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new

    super_admin
  end

  def super_admin
    can :manage, :all
  end
end
