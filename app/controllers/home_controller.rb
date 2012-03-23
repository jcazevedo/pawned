class HomeController < ApplicationController
  def index
    @player = Player.find(current_player.id) if current_player != nil
    @ratings = @player.ratings if @player != nil

    @tournaments = @player.tournaments if @player != nil

    respond_to do |format|
      format.html # index.html.erb
#      format.json { render json: @player }
    end
  end
end
