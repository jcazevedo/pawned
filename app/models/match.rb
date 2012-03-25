class Match < ActiveRecord::Base
  belongs_to :white_player, :class_name => "Player", :foreign_key => "white_id"
  belongs_to :black_player, :class_name => "Player", :foreign_key => "black_id"

  belongs_to :round
  has_one :tournament, :through => :round

  validates :white_id, :black_id, :presence => true
  validates_with MatchDateValidator

  def result
    [white_result.to_s, black_result.to_s].join('-')
  end

  def result=(result)
    split = result.split('-', 2)
    self.white_result = split.first.to_f
    self.black_result = split.last.to_f
  end
end
