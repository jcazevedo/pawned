class CreateDuels < ActiveRecord::Migration
  def change
    create_table :duels do |t|
      t.integer :white_id
      t.integer :black_id
      t.integer :white_result
      t.integer :black_result

      t.timestamps
    end
  end
end
