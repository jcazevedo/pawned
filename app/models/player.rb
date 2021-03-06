class Player < ActiveRecord::Base
  ROLES = %w[admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable, :confirmable, :lockable, :timeoutable

  attr_accessor :login
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :username, :show_email, :login

  has_many :tournament_players
  has_many :tournaments, :through => :tournament_players
  has_many :administered_tournaments, :class_name => "Tournament", :foreign_key => "admin_id"
  has_many :duels_as_white, :class_name => "Duel", :foreign_key => "white_id"
  has_many :duels_as_black, :class_name => "Duel", :foreign_key => "black_id"
  has_many :ratings, :order => "date ASC"
  has_many :standings

  validates :username, :email, :presence => true
  validates :username, :email, :uniqueness => true
  validates :username, :format => { :with => /^[a-zA-Z1-9_]+$/, :message => 'may only contain alphanumerical characters and "_"' }

  after_create :set_initial_rating

  # needed so we can login with both email and username
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where("lower(username) = ? OR lower(email) = ?", login.strip.downcase, login.strip.downcase).first
  end

  # for the roles system
  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def role_symbols
    roles.map(&:to_sym)
  end

  def admin?
    roles.include?("admin")
  end

  # returns either the full name, preferably, or the username
  def given_name
    name.blank? ? username : name
  end

  # needed so admin can do whatever it wants without prompting for user confirmation
  def skip_confirmation!
    self.confirmed_at = Time.now.utc
  end

  def skip_reconfirmation!
    @bypass_postpone = true
  end

  # matches control
  def matches
    self.duels_as_white.map { |d| d.matches }.flatten.compact +
    self.duels_as_black.map { |d| d.matches }.flatten.compact
  end

  def matches_as_white
    matches.map { |m| m if m.white_id == self.id }.compact
  end

  def matches_as_black
    matches.map { |m| m if m.black_id == self.id }.compact
  end

  def matches_won
    (matches.map { |m| m if m.winner == self }).compact
  end

  def matches_lost
    (matches.map { |m| m if !m.winner.nil? and m.winner != self }).compact
  end

  def matches_drawn
    matches - (matches_won + matches_lost)
  end

  def streak_winning
    ((matches.map { |m| 1 if m.winner == self }).compact).split(0).max_by { |s| s.count }.count
  end

  def streak_losing
    ((matches.map { |m| 1 if !m.winner.nil? and m.winner != self }).compact).split(0).max_by { |s| s.count }.count
  end

  def wins_strongest
    m = matches_won.max_by { |m| m.white_player == self ? m.black_rating.previous.value : m.white_rating.previous.value }
    return 0 if m.nil?
    (m.white_player == self ? m.black_rating : m.white_rating).previous.value
  end

  def wins_weakest
    m = matches_won.min_by { |m| m.white_player == self ? m.black_rating.previous.value : m.white_rating.previous.value }
    return 0 if m.nil?
    (m.white_player == self ? m.black_rating : m.white_rating).previous.value
  end

  def tournaments_won
    standings.map { |s| s.position if (s.round.tournament.status == 'Finished' and s.position == 1) }.compact
  end

  def closed_standings
    standings.map { |s| s if (s.round.tournament.status == 'Finished') }.compact.compact
  end

  private

  def set_initial_rating
    self.ratings << Rating.create(:date => DateTime.new(1970, 1, 1), :value => 1300)
  end
end
