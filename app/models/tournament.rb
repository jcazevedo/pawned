class Tournament < ActiveRecord::Base
  STATUSES = %w[open ongoing finished]

	has_many :rounds, :dependent => :destroy
	has_many :tournament_players
	has_many :players, :through => :tournament_players

  belongs_to :admin, :class_name => "Player", :foreign_key => "admin_id"

  validates :name, :status, :date_started, :presence => true
end
