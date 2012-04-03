class StandingsPlayerUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.map(&:player_id).uniq.size != value.size
      record.standings.each do |standing|
        if value.find_all{ |s| s.player_id == standing.player_id }.length != 1
          standing.errors[:player_id] << "Player values must be unique"
        end
      end
      record.errors[attribute] << "Player values must be unique"
    end
  end
end
