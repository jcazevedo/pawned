class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.references :round
      t.references :player
      t.decimal :points
      t.integer :position

      t.timestamps
    end
    add_index :standings, :round_id
    add_index :standings, :player_id
  end
end
