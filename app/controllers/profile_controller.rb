class ProfileController < ApplicationController
  before_filter :authenticate_player!

  # GET /profile(/:login)
  # GET /profile(/:login).json
  def show
    @player = params[:login].blank? ? current_player : Player.find_by_login(params[:login])

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
