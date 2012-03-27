class Tournament < ActiveRecord::Base
  STATUSES = %w[open ongoing finished]

  has_many :rounds, :dependent => :destroy
  has_many :tournament_players
  has_many :players, :through => :tournament_players

  belongs_to :admin, :class_name => "Player", :foreign_key => "admin_id"

  validates :name, :status, :date_started, :presence => true

  default_scope order('date_started desc')

  scope :open, where('date_started >= ?', Date.today)
  scope :ongoing, where('date_started >= ? AND date_finished <= ?', Date.today, Date.today)
end
