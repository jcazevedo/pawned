class UpcomingMatchesController < ApplicationController
  before_filter :authenticate_player!

  def show
    @player = current_player
  end
end
