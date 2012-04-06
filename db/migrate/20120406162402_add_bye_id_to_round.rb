class AddByeIdToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :bye_id, :integer

  end
end
