class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
  end


  def new
  end

  def edit
  end

  def destroy
  end

  def update
  end

  def show
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end


end
