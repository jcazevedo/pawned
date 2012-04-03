class StandingsPositionUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.map(&:position).uniq.size != value.size
      record.standings.each do |standing|
        if value.find_all{ |s| s.position == standing.position }.length != 1
          standing.errors[:position] << "Position values must be unique"
        end
      end
      record.errors[attribute] << "Position values must be unique"
    end
  end
end
