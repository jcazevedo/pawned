class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :matches, :dependent => :destroy
  has_one :standing, :dependent => :destroy
  validates :tournament_id, :tournament_round_id, presence: true
  
  
    def new_round_id
        begin
            last_round = Round.last(:conditions => ["tournament_id = ?", tournament_id], :order => "tournament_round_id ASC").tournament_round_id
        rescue
            last_round = nil
        end
        return last_round == nil ? 1 : last_round + 1 
        
    end
end
