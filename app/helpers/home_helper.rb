module HomeHelper
  def max_rating(ratings)
    unless ratings.empty?
      ratings.max_by {|m| m.value}.value
    else
      0
    end
  end

  def min_rating(ratings)
    unless ratings.empty?
      ratings.min_by {|m| m.value}.value
    else
      0
    end
  end

  def tournament_best
    unless @player.closed_standings.empty?
      @player.closed_standings.max_by {|s| s.position }.position
    else
      0
    end
  end

  def tournament_worst
    unless @player.closed_standings.empty?
      @player.closed_standings.min_by {|s| s.position}.position
    else
      0
    end
  end

  def tournament_latest
    unless @player.closed_standings.empty?
      @player.closed_standings.max_by {|s| s.created_at}.position
    else
      0
    end
  end
end
