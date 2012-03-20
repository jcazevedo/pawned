class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :tournament_id
      t.integer :tournament_round_id

      t.timestamps
    end
  end
end
