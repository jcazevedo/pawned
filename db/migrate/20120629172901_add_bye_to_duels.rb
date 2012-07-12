class AddByeToDuels < ActiveRecord::Migration
  def change
    add_column :duels, :bye, :boolean
  end
end
