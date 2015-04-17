class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in_user(@user)
      redirect_to user_url(@user)
    else
      render :new
    end

  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    log_out_user
    redirect_to new_session_url
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end


end
