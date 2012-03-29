class Match < ActiveRecord::Base
  belongs_to :white_player, :class_name => "Player", :foreign_key => "white_id"
  belongs_to :black_player, :class_name => "Player", :foreign_key => "black_id"
  has_many :ratings

  belongs_to :round
  has_one :tournament, :through => :round

  validates :white_id, :black_id, :presence => true
  validates_with MatchDateValidator
  validates_with MatchPlayersValidator

  after_save :check_for_rating_update

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

  def update_ratings
    old_white_rating = ratings.empty? ? white_player.ratings[-1].value : white_player.ratings[-2].value
    old_black_rating = ratings.empty? ? black_player.ratings[-1].value : black_player.ratings[-2].value

    new_white_rating = Rating.new_rating(white_player.matches.find_all { |match| match.date_played <= date_played }.length - 1,
                                         old_white_rating,
                                         old_black_rating,
                                         white_result)
    new_black_rating = Rating.new_rating(black_player.matches.find_all { |match| match.date_played <= date_played }.length - 1,
                                         old_black_rating,
                                         old_white_rating,
                                         black_result)
    if ratings.empty?
      white_rating = Rating.create(:player_id => white_id,
                                   :value => new_white_rating,
                                   :date => date_played.to_s)
      ratings << white_rating
      black_rating = Rating.create(:player_id => black_id,
                                   :value => new_black_rating,
                                   :date => date_played.to_s)
      ratings << black_rating
    else
      ratings.each do |rating|
        if rating.player == white_player
          rating.value = new_white_rating
          rating.date = date_played.to_s
          rating.save
          
          white_rating = rating
        elsif rating.player == black_player
          rating.value = new_black_rating
          rating.date = date_played.to_s
          rating.save
          black_rating = rating
        end
      end
    end

    white_rating.next.match.update_ratings if !white_rating.next.nil?
    black_rating.next.match.update_ratings if !black_rating.next.nil?
  end

  private

  def check_for_rating_update
    if (white_result_changed? or black_result_changed?) and 
        !white_result.nil? and 
        !black_result.nil?
      update_ratings
    end
  end
end
