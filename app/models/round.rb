class Round < ActiveRecord::Base
	belongs_to :tournament
	has_many :matches

  validates :tournament_id, :tournament_round_id, :presence => true
  validates :tournament_round_id, :uniqueness => true
end
