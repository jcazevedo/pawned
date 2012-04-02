class ChangeDataTypeForDuelResults < ActiveRecord::Migration
  def up
    change_table :duels do |d|
      d.change :white_result, :float
      d.change :black_result, :float
    end
  end

  def down
    change_table :duels do |d|
      d.change :white_result, :integer
      d.change :black_result, :integer
    end
  end
end
