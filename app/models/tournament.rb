class Tournament < ActiveRecord::Base
  STATUSES = %w[Open Ongoing Finished Closed]

  has_many :rounds, :dependent => :destroy
  has_many :tournament_players
  has_many :players, :through => :tournament_players

  belongs_to :admin, :class_name => "Player", :foreign_key => "admin_id"

  validates :name, :date_started, :presence => true, :on => :create
  validates :name, :date_started, :status, :matches_per_duel, :presence => true, :on => :update
  validates :matches_per_duel, :presence => true
  before_create :set_default_values

  default_scope order('date_started desc')

  def latest_standings
    return nil if rounds.empty?
    rounds_st = rounds.map { |r| r if !r.standings.empty? }.reject { |r| r.nil? }

    return nil if rounds_st.empty?
    rounds_st.max_by { |r| r.tournament_round_id }.standings
  end

  def status
    return 0 if status_index.nil?
    STATUSES[status_index]
  end

  def status=(status)
    self.status_index = STATUSES.index(status)
  end

  def set_default_values
    self.status_index ||= 0
    self.matches_per_duel ||= 2
    self.pairing_system = RandomPairing.name
  end

  def available_pairing_systems
    Pairing.subclasses.map { |p| p.name }
  end

  def new_round
    pairing_system.constantize.generate(self)
  end

  def available_tiebreakers
    Tiebreaker.subclasses.map { |p| p.name }
  end
  
  def tiebreakers_selection=(tiebreakers)
    self.tiebreakers = tiebreakers.reject { |t| t.blank? }.join(",")
  end

  def tiebreakers_selection
    self.tiebreakers.split(",")
  end
end
