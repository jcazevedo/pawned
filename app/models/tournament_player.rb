class TournamentPlayer < ActiveRecord::Base
	belongs_to :tournament
	belongs_to :player
end
