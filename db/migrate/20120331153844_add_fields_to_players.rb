class AddFieldsToPlayers < ActiveRecord::Migration
  def up
    change_table :players do |t|
      t.string :login
      t.boolean :show_email
    end
  end

  def down
    change_table :players do |t|
      t.remove :login
      t.remove :show_email
    end
  end
end
