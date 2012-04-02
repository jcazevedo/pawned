class DuelsController < ApplicationController
  before_filter :authenticate_player!

  # GET /tournament/:tournament_id/round/:round_id/duels
  # GET /tournament/:tournament_id/round/:round_id/duels.json
  def index
    # TODO THIS IS NOT WORKING ATM
    # @duels = duel.all

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @duels }
    # end

    render :nothing => true
  end

  # GET /tournament/:tournament_id/round/:round_id/duels/1
  # GET /tournament/:tournament_id/round/:round_id/duels/1.json
  def show
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:id])
    authorize! :read, @duel

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @duel }
    end
  end

  # GET /tournament/:tournament_id/round/:round_id/duels/new
  # GET /tournament/:tournament_id/round/:round_id/duels/new.json
  def new
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.build
    authorize! :create, @duel

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @duel }
    end
  end

  # GET /tournament/:tournament_id/round/:round_id/duels/1/edit
  def edit
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:id])
    authorize! :manage, @duel
  end

  # POST /tournament/:tournament_id/round/:round_id/duels
  # POST /tournament/:tournament_id/round/:round_id/duels.json
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.build(params[:duel])
    authorize! :create, @duel

    respond_to do |format|
      if @duel.save
        format.html { redirect_to tournament_round_duel_url(@tournament, @round, @duel), notice: 'duel was successfully created.' }
        format.json { render json: @duel, status: :created, location: @duel }
      else
        format.html { render action: "new" }
        format.json { render json: @duel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tournament/:tournament_id/round/:round_id/duels/1
  # PUT /tournament/:tournament_id/round/:round_id/duels/1.json
  def update
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:id])
    authorize! :manage, @duel

    respond_to do |format|
      if @duel.update_attributes(params[:duel])
        format.html { redirect_to tournament_round_duel_url(@tournament, @round, @duel), notice: 'duel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @duel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournament/:tournament_id/round/:round_id/duels/1
  # DELETE /tournament/:tournament_id/round/:round_id/duels/1.json
  def destroy
    @tournament = Tournament.find(params[:tournament_id])
    @round = @tournament.rounds.find(params[:round_id])
    @duel = @round.duels.find(params[:id])
    authorize! :manage, @duel

    @duel.destroy

    respond_to do |format|
      format.html { redirect_to tournament_round_path(@tournament, @round) }
      format.json { head :no_content }
    end
  end
end
