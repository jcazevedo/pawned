class TournamentsController < ApplicationController
  before_filter :authenticate_player!

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.accessible_by(current_ability)
    @index_type = "All"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tournaments }
    end
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    @tournament = Tournament.find(params[:id])
    @latest_standings = @tournament.latest_standings.nil? ? nil : @tournament.latest_standings.paginate(:page => params[:page], :per_page => 6)
    authorize! :read, @tournament

    respond_to do |format|
      format.html # show.html.erb
      format.js # show.html.erb
      format.json { render json: @tournament }
    end
  end

  # GET /tournaments/new
  # GET /tournaments/new.json
  def new
    @tournament = Tournament.new(:date_started => Date.today)
    authorize! :create, @tournament

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tournament }
    end
  end

  # GET /tournaments/1/edit
  def edit
    @tournament = Tournament.find(params[:id])
    unless request.referer == edit_tournament_url(@tournament)
      session[:return_to] = request.referer
    end
    authorize! :manage, @tournament
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(params[:tournament])
    @tournament.admin ||= current_player
    authorize! :create, @tournament

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render json: @tournament, status: :created, location: @tournament }
      else
        format.html { render action: "new" }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tournaments/1
  # PUT /tournaments/1.json
  def update
    @tournament = Tournament.find(params[:id])
    authorize! :manage, @tournament

    respond_to do |format|
      if @tournament.update_attributes(params[:tournament])
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament = Tournament.find(params[:id])
    authorize! :manage, @tournament

    @tournament.destroy

    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
  end

  # GET /tournaments/:id/enroll
  # GET /tournaments/:id/enroll.json
  def enroll
    @tournament = Tournament.find(params[:id])
    @participation = TournamentPlayer.new(player: current_player, tournament: @tournament)
    authorize! :create, @participation

    respond_to do |format|
      if @participation.save
        format.html { redirect_to request.referer, notice: 'Successfully signed up to the tournament.' }
        format.json { render json: @participation, status: :created, location: @participation }
      else
        format.html { redirect_to request.referer, :alert => "Can't sign up for this tournament." }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /tournaments/:id/withdraw
  # GET /tournaments/:id/withdraw.json
  def withdraw
    @tournament = Tournament.find(params[:id])
    @participation = @tournament.tournament_players.where(player_id: current_player.id).first
    authorize! :destroy, @participation

    respond_to do |format|
      if(@participation.destroy)
        format.html { redirect_to request.referer, :notice => "Successfully withdrew from tournament." }
        format.json { head :no_content }
      else
        format.html { redirect_to request.referer, :alert => "Couldn't withdraw from tournament." }
        format.json { head :no_content }
      end
    end
  end

  # GET /tournaments/open
  # GET /tournaments/open.json
  # def open
  #   @tournaments = Tournament.where(:status_index => 0)
  #   @index_type = "Open"

  #   respond_to do |format|
  #     format.html { render action: "index" } # index.html.erb
  #     format.json { render json: @tournament }
  #   end
  # end

  # GET /tournaments/open
  # GET /tournaments/open.json
  # def ongoing
  #   @tournaments = Tournament.where(:status_index => 1)
  #   @index_type = "Ongoing"

  #   respond_to do |format|
  #     format.html { render action: "index" } # index.html.erb
  #     format.json { render json: @tournament }
  #   end
  # end
end
