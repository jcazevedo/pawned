class Duel < ActiveRecord::Base
  attr_accessor :matches_to_create
  attr_accessible :white_id, :black_id, :round_id, :result, :matches_to_create

  belongs_to :round
  belongs_to :white_player, :class_name => "Player", :foreign_key => "white_id"
  belongs_to :black_player, :class_name => "Player", :foreign_key => "black_id"
  has_one :tournament, :through => :round
  has_many :matches, :dependent => :destroy

  validates :white_id, :black_id, :presence => true
  validates :matches_to_create, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

  after_save :create_matches
  after_save :update_bye
  after_destroy :destroy_bye

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

  def date
    match_dates = self.matches.map { |m| m.date unless m.date.nil? }.compact
    return nil if match_dates.empty?
    match_dates.max
  end

  #Creates the number of matches defined at self.match_num, alternating white_id with black_id
  def create_matches
    if self.matches.empty?
      # safeguarding what should already be safe
      if tournament.present?
        self.matches_to_create = self.tournament.matches_per_duel
      end

      # create the matches
      self.matches_to_create.to_i.times do |i|
        match = matches.build(:reverse_positions => !(i%2).zero?)
        match.save
      end
    end
  end

  def update_bye
    unless self.round.nil?
      if self.round.tournament.players.count % 2 == 1 and
          self.round.duels.count == (self.round.tournament.players.count - 1)/2
        self.round.bye = (self.round.tournament.players -
          (self.round.duels.map { |r| r.black_player } +
            self.round.duels.map { |r| r.white_player })).first
        self.round.save()
      end
    end
  end

  def destroy_bye
    unless self.round.nil?
      unless self.round.bye.nil?
        self.round.bye = nil
        self.round.save
      end
    end
  end
end
