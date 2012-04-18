class TournamentPlayerStatusValidator < ActiveModel::Validator
  def validate(record)
    if(record.tournament.status != 'Open')
      record.errors[:base] << "This tournament is not open for you to join it."
    end
  end
end

