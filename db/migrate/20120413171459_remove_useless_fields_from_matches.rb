class RemoveUselessFieldsFromMatches < ActiveRecord::Migration
  def up
    change_table :matches do |t|
      t.remove :date_inserted
      t.remove :white_id
      t.remove :black_id
    end
  end

  def down
    change_table :matches do |t|
      t.date :date_inserted
      t.integer :white_id
      t.integer :black_id
    end
  end
end
