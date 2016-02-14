class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :no_cache
  
  private
  # makes sure that current_user is available from views  
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]
  end
  
  def require_login
    if current_user.nil? then
      flash[:danger] = 'Du måste logga in för att se sidan du efterfrågade.'
      redirect_to root_path
    end
  end
  
  def check_admin_rights
    unless current_user.admin?
      flash[:danger] = 'Du har inte rättigheter att visa sidan du efterfrågade.'
      redirect_to clients_path
    end
  end
  
  def no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
end
