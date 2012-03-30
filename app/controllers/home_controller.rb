class HomeController < ApplicationController
  def index
    if current_player
      @player = current_player
      @ratings = @player.ratings
      @tournaments = @player.tournaments
    end

    @rankings = Rating.rankings

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
