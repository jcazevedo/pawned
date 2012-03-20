class TournamentPlayersController < ApplicationController
  # GET /tournament_players
  # GET /tournament_players.json
  def index
    @tournament_players = TournamentPlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tournament_players }
    end
  end

  # GET /tournament_players/1
  # GET /tournament_players/1.json
  def show
    @tournament_player = TournamentPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tournament_player }
    end
  end

  # GET /tournament_players/new
  # GET /tournament_players/new.json
  def new
    @tournament_player = TournamentPlayer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tournament_player }
    end
  end

  # GET /tournament_players/1/edit
  def edit
    @tournament_player = TournamentPlayer.find(params[:id])
  end

  # POST /tournament_players
  # POST /tournament_players.json
  def create
    @tournament_player = TournamentPlayer.new(params[:tournament_player])

    respond_to do |format|
      if @tournament_player.save
        format.html { redirect_to @tournament_player, notice: 'Tournament player was successfully created.' }
        format.json { render json: @tournament_player, status: :created, location: @tournament_player }
      else
        format.html { render action: "new" }
        format.json { render json: @tournament_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tournament_players/1
  # PUT /tournament_players/1.json
  def update
    @tournament_player = TournamentPlayer.find(params[:id])

    respond_to do |format|
      if @tournament_player.update_attributes(params[:tournament_player])
        format.html { redirect_to @tournament_player, notice: 'Tournament player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tournament_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournament_players/1
  # DELETE /tournament_players/1.json
  def destroy
    @tournament_player = TournamentPlayer.find(params[:id])
    @tournament_player.destroy

    respond_to do |format|
      format.html { redirect_to tournament_players_url }
      format.json { head :no_content }
    end
  end
end
