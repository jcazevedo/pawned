class RoundsController < ApplicationController
  before_filter :authenticate_player!

  # GET /tournament/:tournament_id/rounds
  # GET /tournament/:tournament_id/rounds.json
  def index
    # TODO THIS DOESN'T WORK ATM
    # @tournament = Tournament.find(params[:tournament_id])
    # @rounds = @tournament.rounds

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @rounds }
    # end

    render :nothing => true
  end

  # GET /tournament/:tournament_id/rounds/1
  # GET /tournament/:tournament_id/rounds/1.json
  def show
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:id])
    @standings = @round.standings

    authorize! :read, @round

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @round }
    end
  end

  # GET /tournament/:tournament_id/rounds/new
  # GET /tournament/:tournament_id/rounds/new.json
  def new
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.build
    authorize! :create, @round

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @round }
    end
  end

  # GET /tournament/:tournament_id/rounds/1/edit
  def edit
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:id])
    @players = @tournament.players
    positions = (1..@players.length).to_a
    @players.each do |player|
      if !player.id.in? @round.standings.map { |s| s.player_id }
        @round.standings << Standing.new(:player_id => player.id,
                                         :position => positions[0])
        positions.shift
      else
        positions.delete(@round.standings.where(:player_id => player.id).first.position)
      end
    end

    authorize! :manage, @round
  end

  # POST /tournament/:tournament_id/rounds
  # POST /tournament/:tournament_id/rounds.json
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.build(params[:round])
    authorize! :create, @round

    respond_to do |format|
      if @round.save
        format.html { redirect_to tournament_round_url(@tournament, @round), notice: 'Round was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        format.html { render action: "new" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tournament/:tournament_id/rounds/1
  # PUT /tournament/:tournament_id/rounds/1.json
  def update
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:id])
    @players = @tournament.players
    authorize! :manage, @round

    respond_to do |format|
      if @round.update_attributes(params[:round])
        format.html { redirect_to tournament_round_url(@tournament, @round), notice: 'Round was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournament/:tournament_id/rounds/1
  # DELETE /tournament/:tournament_id/rounds/1.json
  def destroy
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:id])
    authorize! :manage, @round

    @round.destroy

    respond_to do |format|
      format.html { redirect_to tournament_url(@tournament) }
      format.json { head :no_content }
    end
  end
end
