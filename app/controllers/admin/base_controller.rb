class Admin::BaseController < ApplicationController
  def verify_admin!
    redirect_to(root_url, :alert => "You are not authorized to access that page.") unless current_player.admin?
  end

  before_filter :authenticate_player!
  before_filter :verify_admin!
end
