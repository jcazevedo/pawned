class AddPairingSystemToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :pairing_system, :string

  end
end
