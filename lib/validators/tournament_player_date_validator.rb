class TournamentPlayerDateValidator < ActiveModel::Validator
  def validate(record)
    if(record.tournament.date_started < Date.today)
      record.errors[:base] << "Can't sign up for a tournament that already started."
    end
  end
end
