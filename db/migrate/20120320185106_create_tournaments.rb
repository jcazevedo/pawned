class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :date_started
      t.date :date_finished
      t.integer :status
      t.integer :admin_id

      t.timestamps
    end
  end
end
