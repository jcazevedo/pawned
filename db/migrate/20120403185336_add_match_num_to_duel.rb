class AddMatchNumToDuel < ActiveRecord::Migration
  def change
    add_column :duels, :match_num, :integer

  end
end
