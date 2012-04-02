class MatchesController < ApplicationController
  before_filter :authenticate_player!

  # GET /tournament/:tournament_id/round/:round_id/matches
  # GET /tournament/:tournament_id/round/:round_id/matches.json
  def index
    # TODO THIS IS NOT WORKING ATM
    # @matches = Match.all

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @matches }
    # end

    render :nothing => true
  end

  # GET /tournament/:tournament_id/round/:round_id/matches/1
  # GET /tournament/:tournament_id/round/:round_id/matches/1.json
  def show
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:duel_id])
    @match = @duel.matches.find(params[:id])
    authorize! :read, @match

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @match }
    end
  end

  # GET /tournament/:tournament_id/round/:round_id/matches/new
  # GET /tournament/:tournament_id/round/:round_id/matches/new.json
  def new
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:duel_id])
    @match = @duel.matches.build

    authorize! :create, @match

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @match }
    end
  end

  # GET /tournament/:tournament_id/round/:round_id/matches/1/edit
  def edit
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:duel_id])
    @match = @duel.matches.find(params[:id])

    authorize! :manage, @match
  end

  # POST /tournament/:tournament_id/round/:round_id/matches
  # POST /tournament/:tournament_id/round/:round_id/matches.json
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:duel_id])
    @match = @duel.matches.build(params[:match])

    authorize! :create, @match

    respond_to do |format|
      if @match.save
        format.html { redirect_to tournament_round_duel_match_url(@tournament, @round, @duel, @match), notice: 'Match was successfully created.' }
        format.json { render json: @match, status: :created, location: @match }
      else
        format.html { render action: "new" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tournament/:tournament_id/round/:round_id/matches/1
  # PUT /tournament/:tournament_id/round/:round_id/matches/1.json
  def update
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:duel_id])
    @match = @duel.matches.find(params[:id])

    authorize! :manage, @match

    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to tournament_round_match_url(@tournament, @round, @match), notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournament/:tournament_id/round/:round_id/matches/1
  # DELETE /tournament/:tournament_id/round/:round_id/matches/1.json
  def destroy
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:duel_id])
    @match = @duel.matches.find(params[:id])

    authorize! :manage, @match

    @match.destroy

    respond_to do |format|
      format.html { redirect_to tournament_round_path(@tournament, @round) }
      format.json { head :no_content }
    end
  end
end
