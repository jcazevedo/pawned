class ParticipationsController < ApplicationController
  # POST /participations
  # POST /participations.json
  def create
    @participation = TournamentPlayer.new(params[:tournament_player])
    authorize! :create, @participation

    respond_to do |format|
      if @participation.save
        format.html { redirect_to @participation.tournament, notice: 'Successfully signed up to the tournament.' }
        format.json { render json: @participation, status: :created, location: @participation }
      else
        format.html { redirect_to @participation.tournament, :alert => "Can't sign up for this tournament." }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/:id
  # DELETE /participations/:id.json
  def destroy
    @participation = TournamentPlayer.find(params[:id])
    @tournament = @participation.tournament
    authorize! :manage, @participation

    respond_to do |format|
      if(@participation.destroy)
        format.html { redirect_to @tournament, :notice => "Successfully withdrew from tournament." }
        format.json { head :no_content }
      else
        format.html { redirect_to @tournament, :alert => "Couldn't withdraw from tournament." }
        format.json { head :no_content }
      end
    end
  end
end
