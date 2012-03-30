class Player < ActiveRecord::Base
  ROLES = %w[admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable, :confirmable, :lockable, :timeoutable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :tournament_players
  has_many :tournaments, :through => :tournament_players
  has_many :administered_tournaments, :class_name => "Tournament", :foreign_key => "admin_id"
  has_many :matches_as_white, :class_name => "Match", :foreign_key => "white_id"
  has_many :matches_as_black, :class_name => "Match", :foreign_key => "black_id"
  has_many :ratings, :order => "created_at ASC"

  after_create :set_initial_rating

  def matches
    matches_as_white + matches_as_black
  end

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

  def matches_won
    (matches.map { |m| m if m.winner == self }).reject { |r| r.nil? }
  end

  def matches_lost
    (matches.map { |m| m if !m.winner.nil? and m.winner != self }).reject { |r| r.nil? }
  end

  def matches_drawn
    matches - (matches_won + matches_lost)
  end

  def streak_winning
    ((matches.map { |m| 1 if m.winner == self }).reject { |r| r.nil? }).split(0).max_by { |s| s.count }.count
  end

  def streak_losing
    ((matches.map { |m| 1 if !m.winner.nil? and m.winner != self }).reject { |r| r.nil? }).split(0).max_by { |s| s.count }.count
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

  private

  def set_initial_rating
    self.ratings << Rating.create(:date => created_at,
                                  :value => 1300)
  end
end
