module NavHelper
  def current_controller(c)
    "active" if controller.controller_name == c ||
      controller.class.to_s.split("::").first.downcase! == c
  end
end
