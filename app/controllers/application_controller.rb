class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'admin_lte_2'

  helper_method :current_user

  before_action :authorize

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def authorize
    return if current_user

    redirect_to login_url
  end
end
