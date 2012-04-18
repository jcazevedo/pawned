class TournamentPlayer < ActiveRecord::Base
	belongs_to :tournament
	belongs_to :player

  before_destroy :validate_withdrawal

  validates :tournament_id, :player_id, :presence => true
  validates_with TournamentPlayerStatusValidator

  # don't allow a player to withdraw a tournament if it has already begun
  def validate_withdrawal
    self.tournament.status == 'Open' and self.tournament.rounds.empty?
  end
end

