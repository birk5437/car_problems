class UserSessionsController < ApplicationController

  skip_before_filter :login_required, :only => [:new, :create]

  def new
    @user_session = UserSession.new
    return
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end

  protected

  def require_no_login
    if current_person.present?
      # redirect_to Mobi.homepage_url
      return false
    end
  end

end