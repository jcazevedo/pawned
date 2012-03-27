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
end
