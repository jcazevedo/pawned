class Tournament < ActiveRecord::Base
	has_many :rounds
	has_many :players, :through => :tournament_players
end
