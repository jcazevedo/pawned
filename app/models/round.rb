class Round < ActiveRecord::Base
  belongs_to :tournament

  has_many :duels, :dependent => :destroy
  has_many :standings, :dependent => :destroy, :order => "position ASC"

  # belongs_to :bye, :class_name => "Player", :foreign_key => "bye_id"

  accepts_nested_attributes_for :standings
  accepts_nested_attributes_for :duels
  validates :tournament_id, :tournament_round_id, presence: true
  validates :standings, :standings_position_uniqueness => true
  validates :standings, :standings_player_uniqueness => true

  def new_round_id
    begin
      last_round = Round.last(:conditions => ["tournament_id = ?", tournament_id], :order => "tournament_round_id ASC").tournament_round_id
    rescue
      last_round = nil
    end
    return last_round == nil ? 1 : last_round + 1
  end
end
