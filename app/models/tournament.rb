class Tournament < ActiveRecord::Base
  STATUSES = %w[Open Ongoing Finished Closed]

  has_many :rounds, :dependent => :destroy
  has_many :tournament_players
  has_many :players, :through => :tournament_players

  belongs_to :admin, :class_name => "Player", :foreign_key => "admin_id"

  validates :name, :status_index, :date_started, :presence => true
  before_validation :default_status

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

  def default_status
    status_index ||= 0
  end
end

