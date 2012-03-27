class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :player_id
      t.integer :value
      t.datetime :date
      t.integer :match_id

      t.timestamps
    end
  end
end
