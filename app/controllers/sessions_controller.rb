class SessionsController < ApplicationController
  layout 'application'
  skip_before_action :authorize

  def new; end

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id

    redirect_to root_url, notice: "Welcome <i>#{user.name}!</i>"
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_url
  end
end
