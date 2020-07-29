class UsersController < ApplicationController
  before_action :set_user, only: %i[show update edit]

  def show; end

  def edit; end

  def update
    if @user.update(safe_user_params)
      redirect_to user_path, notice: 'Profile data has been successfully updated!'
    else
      render :edit, alert: @user.errors
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(session[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def safe_user_params
    params.require(:user).permit(:name, :email, :channel, :post_count, :new_avatar)
  end
end
