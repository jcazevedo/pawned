class Tournament < ActiveRecord::Base
	has_many :rounds
	has_many :tournament_players
	has_many :players, :through => :tournament_players

  belongs_to :administrator, :class_name => "Player", :foreign_key => "admin_id"
end
