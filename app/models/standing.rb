class Standing < ActiveRecord::Base
  belongs_to :round
  belongs_to :player

  default_scope order('position asc')

  validates :round_id, :player_id, :points, :position, :presence => true
  validate :unique_position_in_round
  validate :unique_player_in_round

  def unique_position_in_round
    if Standing.where(:round_id => round.id).where('? IS NULL OR id <> ?', id, id).map { |s| s.position }.include?(position)
      errors[:position] << "Position of player must be unique in each round."
    end
  end

  def unique_player_in_round
    if Standing.where(:round_id => round.id).where('? IS NULL OR id <> ?', id, id).map { |s| s.player_id }.include?(player_id)
      errors[:player_id] << "There can only be one standing for a player in each round."
    end
  end
end

