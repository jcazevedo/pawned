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
    authorize! :read, @tournament

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tournament }
    end
  end

  # GET /tournaments/new
  # GET /tournaments/new.json
  def new
    @tournament = Tournament.new
    authorize! :create, @tournament

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tournament }
    end
  end

  # GET /tournaments/1/edit
  def edit
    @tournament = Tournament.find(params[:id])
    authorize! :manage, @tournament
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(params[:tournament])
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

  # GET /tournaments/open
  # GET /tournaments/open.json
  def open
    @tournaments = Tournament.where(:status_index => 0)
    @index_type = "Open"

    respond_to do |format|
      format.html { render action: "index" } # index.html.erb
      format.json { render json: @tournament }
    end
  end

  # GET /tournaments/open
  # GET /tournaments/open.json
  def ongoing
    @tournaments = Tournament.where(:status_index => 1)
    @index_type = "Ongoing"

    respond_to do |format|
      format.html { render action: "index" } # index.html.erb
      format.json { render json: @tournament }
    end
  end
end

