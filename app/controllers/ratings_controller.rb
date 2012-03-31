class RatingsController < ApplicationController
  # GET /ratings
  # GET /ratings.json
  def index
    @rankings = Rating.rankings

    respond_to do |format|
      format.html # ratings.html.erb
      format.json { render json: @ratings }
    end
  end
end

