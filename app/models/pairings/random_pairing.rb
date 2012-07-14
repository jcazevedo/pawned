class RandomPairing < Pairing
  def self.generate(tournament)
    round = Round.new
    round.tournament_round_id = tournament.rounds.count + 1

    tournament.players.shuffle.each_slice(2) do |w,b|

      if b.nil?
        round.bye = w
      else
        d = Duel.new
        d.matches_to_create = tournament.matches_per_duel
        d.white_player = w
        d.black_player = b
        round.duels << d
        d.save
      end
      
    end

    tournament.rounds << round
    round.save(validate: false)
  end
end
