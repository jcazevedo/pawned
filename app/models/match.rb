class Match < ActiveRecord::Base
  belongs_to :white_player, :class_name => "Player", :foreign_key => "white_id" 
  belongs_to :black_player, :class_name => "Player", :foreign_key => "black_id"
  has_one :round
end
