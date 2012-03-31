class ChangeLoginFieldNameInPlayers < ActiveRecord::Migration
  def up
    rename_column :players, :login, :username
  end

  def down
    rename_column :players, :username, :login
  end
end
