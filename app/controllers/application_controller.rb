class ApplicationController < ActionController::Base
  protect_from_forgery

  # overriding cancan's current_ability method due to our "user"
  # class being named "player"
  def current_ability
    @current_ability ||= Ability.new(current_player)
  end
end
