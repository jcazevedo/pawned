class AddTiebreakersToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :tiebreakers, :string

  end
end
