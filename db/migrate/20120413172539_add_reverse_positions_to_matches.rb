class AddReversePositionsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :reverse_positions, :boolean
  end
end
