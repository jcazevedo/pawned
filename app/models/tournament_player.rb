class TournamentPlayer < ActiveRecord::Base
	belongs_to :tournament
	belongs_to :player

  validates :tournament_id, :player_id, :presence => true
end
