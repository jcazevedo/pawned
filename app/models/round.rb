class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :matches, :dependent => :destroy

  has_many :standings, :dependent => :destroy
  validates :tournament_id, :tournament_round_id, presence: true
end

