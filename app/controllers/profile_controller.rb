class ProfileController < ApplicationController
  before_filter :authenticate_player!

  # GET /profile(/:username)
  # GET /profile(/:username).json
  def show
    @player = params[:username].blank? ? current_player : Player.find_by_username(params[:username])

    respond_to do |format|
      if @player
        @ratings = @player.ratings
        authorize! :show, @player

        format.html # show.html.erb
        format.json { render json: @player }
      else
        format.html { redirect_to root_url, :alert => 'Profile does not exist.'}
        format.json { render :nothing => true }
      end
    end
  end
end
