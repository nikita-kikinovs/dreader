# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update edit]

  # renders form with disabled input fields
  def show; end

  # renders form with enabled input fields
  def edit; end

  # updates user data using params received from user edit form
  def update
    if @user.update(safe_user_params)
      redirect_to user_path, notice: 'Profile data has been successfully updated!'
    else
      render :edit, alert: @user.errors
    end
  end

  private

  # sets current user before view render
  def set_user
    @user = User.find(session[:user_id])
  end

  # permits received allowed params
  def safe_user_params
    params.require(:user).permit(:name, :email, :channel_id, :post_count, :new_avatar)
  end
end
