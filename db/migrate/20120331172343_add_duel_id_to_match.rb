class AddDuelIdToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :duel_id, :integer

  end
end
