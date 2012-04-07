class MatchDateValidator < ActiveModel::Validator
  def validate(record)
    # if the match has no tournament it will present no errors
    # useful for previous match insertion
    return if record.tournament.nil?

    # match must be inserted during the date limits of the tournament
    if record.tournament.date_finished.nil?
      unless record.date >= record.tournament.date_started
        record.errors[:date] << "Match must have been played during the tournament."
      end
    else
      unless record.date_played >= record.tournament.date_started and
        record.date <= record.tournament.date_finished
        record.errors[:date] << "Match must have been played during the tournament."
      end
    end
  end
end
