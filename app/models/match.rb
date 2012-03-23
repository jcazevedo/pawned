class Match < ActiveRecord::Base
  belongs_to :white_id, :class_name =>"Player"
  belongs_to :black_id, :class_name =>"Player"
  has_one :round
end
