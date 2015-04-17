class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
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

  def edit
    @user = User.find(params[:id])

    render :edit
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to new_user_url
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])

    render :show
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end


end
