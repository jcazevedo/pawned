class Duel < ActiveRecord::Base
  belongs_to :white_player, :class_name => "Player", :foreign_key => "white_id"
  belongs_to :black_player, :class_name => "Player", :foreign_key => "black_id"
  has_many :matches
  belongs_to :round
  has_one :tournament, :through => :round

  validates :white_id, :black_id, :presence => true


    # TODO The winner might be determined by something other than this comparison

  def winner
    return nil if white_result == black_result
    white_result > black_result ? white_player : black_player
  end

   def result
    return nil if white_result.nil? or black_result.nil?
    [white_result.to_s, black_result.to_s].join('-')
  end

  def result=(result)
    if result.nil? || result.empty?
      self.white_result = nil
      self.black_result = nil
    else
      split = result.split('-', 2)
      self.white_result = split.first.to_f
      self.black_result = split.last.to_f
    end
  end

  def players
    [white_player, black_player]
  end
end
