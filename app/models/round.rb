class Round < ActiveRecord::Base
	belongs_to :tournament
	has_many :matches, :dependent => :destroy

  validates :tournament_id, :tournament_round_id, :presence => true
end
