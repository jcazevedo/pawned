class MatchPlayersValidator < ActiveModel::Validator
  def validate(record)
    return if record.white_player.nil? or record.black_player.nil?

    # white always goes first, even in comparisons
    if record.white_player.id.eql?(record.black_player.id)
      record.errors[:white_player] << "White player can't be the same as the black player."
      record.errors[:black_player] << "Black player can't be the same as the white player."
    end
  end
end
