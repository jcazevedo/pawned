class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Player.new # guest user (not logged in)

    if user.admin?
      # One Admin to rule them all, One Admin to find them,
      # One Admin to bring them all and in the darkness bind them
      # In the Land of Pawned where the Whites and Blacks lie.
      can :manage, :all
    else
      # can manage a tournament as long as it's its administrator
      can :manage, Tournament, :admin_id => user.id

      # can manage its own profile
      can :manage, Player, :id => user.id

      # can manage a round if that round belongs to a tournament it administers
      can :manage, Round do |r|
        r.tournament.admin.id.eql?(user.id)
      end

      # can manage a match if that match belongs to a round that belongs to a whatveryougettheidea
      can :manage, Match do |m|
        m.round.tournament.admin.id.eql?(user.id)
      end

      # can manage its own sign-ups to tournaments or the signings of tournaments it owns
      can :manage, TournamentPlayer do |tp|
        tp.player.id.eql?(user.id) or tp.tournament.admin.id.eql?(user.id)
      end

      # can read a bunch of stuff just as long as it's signed in
      can [:read, :create], Tournament
      can :read, Player
      can :read, Round
      can :read, Match
      can :read, TournamentPlayer # not sure if this is necessary
      can :read, Rating
    end
  end
end
