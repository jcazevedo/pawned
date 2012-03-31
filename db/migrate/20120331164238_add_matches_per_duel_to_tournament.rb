class AddMatchesPerDuelToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :matches_per_duel, :integer

  end
end
