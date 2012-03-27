class PlayersController < ApplicationController
  # GET /players/1/tournaments
  # GET /players/1/tournaments.json
  def tournaments
    @player = Player.find(params[:id])
    @tournaments = @player.tournaments

    respond_to do |format|
      format.html # tournaments.html.erb
      format.json { render json: @players }
    end
  end
end
