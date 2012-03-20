class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.date :date_inserted
      t.date :date_played
      t.integer :white_id
      t.integer :black_id
      t.float :white_result
      t.float :black_result
      t.integer :round_id
      t.text :png_text

      t.timestamps
    end
  end
end
