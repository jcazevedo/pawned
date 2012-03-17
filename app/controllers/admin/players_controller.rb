class Admin::PlayersController < ApplicationController
  before_filter :authenticate_player!

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:player])

    if(@player.save)
      respond_to do |format|
        format.html { redirect_to @player, notice: "Player successfully created." }
        format.json { render nothing: true }
      end
    else
      render :new
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])

    if(@player.update_attributes(params[:player]))
      redirect_to @player, notice: "Player successfully created."
    else
      render :edit
    end
  end

  def destroy
    @player = Player.find(params[:id])

    @player.destroy

    redirect_to admin_players_path
  end
end
