class RenameTournamentStatusToStatusMask < ActiveRecord::Migration
  def up
    rename_column :tournaments, :status, :status_index
  end

  def down
    rename_column :tournaments, :status_index, :status
  end
end
