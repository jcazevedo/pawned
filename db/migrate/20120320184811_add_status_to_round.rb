class AddStatusToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :status, :integer

  end
end
