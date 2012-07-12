module RandomPairing
  def self.generate(tournament)
    round = Round.new
    round.tournament_round_id = tournament.rounds.count + 1

    tournament.players.shuffle.each_slice(2) do |w,b|
      d = Duel.new
      d.matches_to_create = tournament.matches_per_duel
      d.white_player = w

      if b.nil?
        d.bye = true
      else
        d.bye = false
        d.black_player = b
      end

      round.duels << d
      d.save
    end

    tournament.rounds << round
    round.save(validate: false)
  end
end
