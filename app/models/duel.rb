class Duel < ActiveRecord::Base
  belongs_to :white_player, :class_name => "Player", :foreign_key => "white_id"
  belongs_to :black_player, :class_name => "Player", :foreign_key => "black_id"
  has_many :matches
  belongs_to :round
  has_one :tournament, :through => :round

  validates :white_id, :black_id, :match_num, :presence => true
  validates_numericality_of :match_num, :only_integer => true, :message => "It needs to be a positive number."
  validate :positive_num
  after_save :create_match

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

  def positive_num
    errors.add(:match_num, "It needs to be a positive number.") unless self.match_num > 0
  end

  #Creates the number of matches defined at self.match_num, alternating white_id with black_id
  def create_match
    i = 0
    while i < self.match_num.to_i do
      #puts "iter: #{i}"
      white = i % 2 == 0 ? self.white_id : self.black_id
      black = i % 2 == 0 ? self.black_id : self.white_id
      puts "white: #{white} and black: #{black}"
      self.matches << Match.create(:white_id => white, :black_id => black)
      i += 1
    end
  end
end
