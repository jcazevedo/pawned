class Standing < ActiveRecord::Base
  belongs_to :round
  belongs_to :player

  default_scope order('position asc')

  validates :round_id, :player_id, :points, :position, :presence => true
end
