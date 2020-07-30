# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  # using custom template `adminlte 2`
  layout 'admin_lte_2'

  helper_method :current_user

  before_action :authorize

  # sets current_user instance variable with user which is currently logged in
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private

  # checks if there is user logged in, otherwise redirects to login page
  def authorize
    return if current_user

    redirect_to login_url
  end
end
