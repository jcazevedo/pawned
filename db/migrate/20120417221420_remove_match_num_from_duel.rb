class RemoveMatchNumFromDuel < ActiveRecord::Migration
  def up
    remove_column :duels, :match_num
      end

  def down
    add_column :duels, :match_num, :integer
  end
end
