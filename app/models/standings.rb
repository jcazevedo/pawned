class Standings < ActiveRecord::Base
  belongs_to :round_id
  belongs_to :player_id
end
