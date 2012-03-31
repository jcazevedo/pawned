class HomeController < ApplicationController
  def index
    if current_player
      @player = current_player
      @ratings = @player.ratings
      @tournaments = @player.tournaments.map { |t| t if t.status == 'Ongoing'}.reject { |r| r.nil? }
    end

    # TODO Should this change to a new method in the ratings controller?
    @rankings = Rating.rankings.take(10)

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end

