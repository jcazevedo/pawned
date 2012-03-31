class Standing < ActiveRecord::Base
  belongs_to :round
  belongs_to :player

  default_scope order('position asc')

  validate :unique_position_in_round

  def unique_position_in_round
      if Standing.where(:round_id => round.id).where('? IS NULL OR id <> ?', id, id).map { |s| s.position }.include?(position)
        errors[:position] << "Position of player must be unique in each round."
      end
  end
end

