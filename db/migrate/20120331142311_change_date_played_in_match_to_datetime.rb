class ChangeDatePlayedInMatchToDatetime < ActiveRecord::Migration
  def up
    change_column :matches, :date_played, :datetime
  end

  def down
    change_column :matches, :date_played, :date
  end
end
