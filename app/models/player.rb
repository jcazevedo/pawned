class Player < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable, :lockable, :timeoutable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :tournament_players
  has_many :tournaments, :through => :tournament_players
  has_many :matches_w, :class_name => "Match", :foreign_key => "white_id"
  has_many :matches_b, :class_name => "Match", :foreign_key => "black_id"
  has_many :ratings, :order => "date ASC"

  def matches
    matches_w + matches_b
  end
end
