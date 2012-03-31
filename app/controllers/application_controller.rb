class ApplicationController < ActionController::Base
  protect_from_forgery

  # overriding cancan's current_ability method due to our "user"
  # class being named "player"
  def current_ability
    @current_ability ||= Ability.new(current_player)
  end

  # see what happens when you try to do something you're not supposed to
  rescue_from CanCan::AccessDenied do |e|
    flash[:alert] = "You are not authorized to access that page."
    redirect_to root_url
  end
end
