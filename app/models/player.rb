class Player < ActiveRecord::Base
  ROLES = %w[admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable, :lockable, :timeoutable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :tournament_players
  has_many :tournaments, :through => :tournament_players
  has_many :administered_tournaments, :class_name => "Tournament", :foreign_key => "admin_id"
  has_many :matches_as_white, :class_name => "Match", :foreign_key => "white_id"
  has_many :matches_as_black, :class_name => "Match", :foreign_key => "black_id"
  has_many :ratings, :order => "date ASC"

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

  private

  def set_initial_rating
    self.ratings << Rating.create(:date => created_at,
                                  :value => 1300)
  end
end
