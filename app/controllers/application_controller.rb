# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'admin_lte_2'

  helper_method :current_user

  before_action :authorize

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private

  def authorize
    return if current_user

    redirect_to login_url
  end
end
