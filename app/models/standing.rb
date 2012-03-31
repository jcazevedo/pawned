class Standing < ActiveRecord::Base
  belongs_to :round
  belongs_to :player
  validates :round_id, :player_id, :points, :position, :presence => true
end
