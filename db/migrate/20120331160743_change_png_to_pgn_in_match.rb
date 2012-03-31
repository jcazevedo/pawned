class ChangePngToPgnInMatch < ActiveRecord::Migration
  def up
    remove_column :matches, :png_text, :text
    add_column :matches, :pgn_text, :text
  end

  def down
    add_column :matches, :png_text, :text
    remove_column :matches, :pgn_text, :text
  end
end
