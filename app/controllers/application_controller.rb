# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # before_filter :login_required

  # # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :current_user#, :set_current_user

  def logged_in?
    !!current_user && !current_user_session.try(:stale?)
  end

  def login_required
    unless logged_in?
      flash[:error] = "You must be logged in to perform this action."
      flash[:error] = "You have been logged out due to inactivity." if current_user_session.present? && current_user_session.stale?
      redirect_to login_path
    end
  end

  private ############################

  def set_current_user
    Authorization.current_user = current_user
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

end