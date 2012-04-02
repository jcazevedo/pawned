class RemoveRoundIdFromMatch < ActiveRecord::Migration
  def up
    remove_column :matches, :round_id
      end

  def down
    add_column :matches, :round_id, :integer
  end
end
