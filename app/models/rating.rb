class Rating < ActiveRecord::Base
  belongs_to :player
  belongs_to :match

  def self.new_rating(n_previous_games, player_rating, opponent_rating, player_result)
    if (n_previous_games <= 8)
      rating = self.special_rating(n_previous_games, player_rating, opponent_rating, player_result)
      rating
    else
      self.standard_rating(n_previous_games, player_rating, opponent_rating, player_result)
    end
  end

  def previous
    Rating.find(:first, 
                :order => 'created_at DESC', 
                :limit => 1, 
                :conditions => ["created_at < ? AND player_id = ?", created_at, player]).presence
  end

  def next
    Rating.find(:first, 
                :order => 'created_at ASC', 
                :limit => 1, 
                :conditions => ["created_at > ? AND player_id = ?", created_at, player ]).presence
  end

  private
  
  def self.special_rating(n_previous_games, player_rating, opponent_rating, player_result)
    coef = {1.0 => 1, 0.5 => 0, 0.0 => -1}[player_result]
    ((n_previous_games * player_rating + opponent_rating + coef * 400.0) / (n_previous_games + 1.0)).round
  end

  def self.standard_rating(n_previous_games, player_rating, opponent_rating, player_result)
    k = self.k(n_previous_games, player_rating)
    e = self.winning_expectancy(player_rating, opponent_rating)
    (player_rating + k * (player_result - e)).round
  end

  def self.k(n_previous_games, rating)
    prior_games = 50
    prior_games /= Math.sqrt((1 + (2200 - rating)**2) / 100000) if rating < 2200
    prior_games = [prior_games, n_previous_games].min
    800.0 / (prior_games + 1)
  end

  def self.winning_expectancy(player_rating, opponent_rating)
    1.0 / (10**((opponent_rating - player_rating) / 400) + 1.0)
  end
end
