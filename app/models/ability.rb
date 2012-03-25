class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Player.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    else
      can :manage, Tournament, :admin_id => user.id
      can :manage, Player, :id => user.id
      can :manage, Round do |r|
        r.tournament.administrator.id.eql?(user.id)
      end
      can :manage, Match do |m|
        m.round.tournament.administrator.id.eql?(user.id)
      end

      can [:read, :create], Tournament
      can :read, Player
      can :read, Round
      can :read, Match
      can :read, Rating
    end
  end
end
