class RemoveStatusFromRound < ActiveRecord::Migration
  def up
    remove_column :rounds, :status
      end

  def down
    add_column :rounds, :status, :integer
  end
end
