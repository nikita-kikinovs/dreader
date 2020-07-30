# frozen_string_literal: true

class SessionsController < ApplicationController
  layout 'application'

  before_action :check_login, only: :new
  skip_before_action :authorize

  # renders login page
  def new; end

  # sends received authorization hash to user model method. adds user to seesion. redirects to root page
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id

    redirect_to root_url, notice: "Welcome <i>#{user.name}!</i>"
  end

  # removes user_id from session on log-out
  def destroy
    session[:user_id] = nil

    redirect_to root_url
  end

  private

  # checks if user is logged-in. If so redirects to root path
  def check_login
    redirect_to root_path if current_user.present?
  end
end
