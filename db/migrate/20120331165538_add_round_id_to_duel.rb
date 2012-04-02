class AddRoundIdToDuel < ActiveRecord::Migration
  def change
    add_column :duels, :round_id, :integer

  end
end
