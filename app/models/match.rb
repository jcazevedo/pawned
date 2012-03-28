class Match < ActiveRecord::Base
  belongs_to :white_player, :class_name => "Player", :foreign_key => "white_id"
  belongs_to :black_player, :class_name => "Player", :foreign_key => "black_id"
  has_many :ratings

  belongs_to :round
  has_one :tournament, :through => :round

  validates :white_id, :black_id, :presence => true
  validates_with MatchDateValidator
  validates_with MatchPlayersValidator

  after_save :update_ratings

  def result
    return nil if white_result.nil? or black_result.nil?
    [white_result.to_s, black_result.to_s].join('-')
  end

  def result=(result)
    if result.nil?
      self.white_result = nil
      self.black_result = nil
    else
      split = result.split('-', 2)
      self.white_result = split.first.to_f
      self.black_result = split.last.to_f
    end
  end

  def white_rating
    ratings.where(:player_id => self.white_id).last
  end

  def black_rating
    ratings.where(:player_id => self.black_id).last
  end

  # TODO The winner might be determined by something other than this comparison
  def winner
    return nil if white_result == black_result
    white_result > black_result ? white_player : black_player
  end

  private

  def update_ratings
    if white_result_changed? or black_result_changed?
      ratings.destroy_all
      new_white_rating = Rating.new_rating(white_player.matches.length - 1,
                                           white_player.ratings.last.value,
                                           black_player.ratings.last.value,
                                           white_result)
      new_black_rating = Rating.new_rating(black_player.matches.length - 1,
                                           black_player.ratings.last.value,
                                           white_player.ratings.last.value,
                                           black_result)
      ratings << Rating.create(:player_id => white_id,
                               :value => new_white_rating,
                               :date => date_played.to_s)
      ratings << Rating.create(:player_id => black_id,
                               :value => new_black_rating,
                               :date => date_played.to_s)
    end
  end
end
