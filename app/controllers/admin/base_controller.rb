class Admin::BaseController < ApplicationController
  def verify_admin!
    redirect_to(:back, :alert => "You are not authorized to do whatever you were trying to do.") unless current_player.admin?
  end

  before_filter :authenticate_player!
  before_filter :verify_admin!
end
