class StandingsController < ApplicationController
  # GET /standings
  # GET /standings.json
  def index
    @standings = Standing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @standings }
    end
  end

  # GET /standings/1
  # GET /standings/1.json
  def show
    @standing = Standing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @standing }
    end
  end

  # GET /standings/new
  # GET /standings/new.json
  def new
    @standing = Standing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @standing }
    end
  end

  # GET /standings/1/edit
  def edit
    @standing = Standing.find(params[:id])
  end

  # POST /standings
  # POST /standings.json
  def create
    @standing = Standing.new(params[:standing])

    respond_to do |format|
      if @standing.save
        format.html { redirect_to @standing, notice: 'Standing was successfully created.' }
        format.json { render json: @standing, status: :created, location: @standing }
      else
        format.html { render action: "new" }
        format.json { render json: @standing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /standings/1
  # PUT /standings/1.json
  def update
    @standing = Standing.find(params[:id])

    respond_to do |format|
      if @standing.update_attributes(params[:standing])
        format.html { redirect_to @standing, notice: 'Standing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @standing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /standings/1
  # DELETE /standings/1.json
  def destroy
    @standing = Standing.find(params[:id])
    @standing.destroy

    respond_to do |format|
      format.html { redirect_to standings_url }
      format.json { head :no_content }
    end
  end
end
