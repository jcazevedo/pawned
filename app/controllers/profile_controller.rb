class ProfileController < ApplicationController
  before_filter :authenticate_player!

  # GET /profile
  # GET /profile.json
  def show
    @player = current_player
    @ratings = @player.ratings

    authorize! :show, @player

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end
end
