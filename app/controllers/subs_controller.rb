class SubsController < ApplicationController

  before_action :is_logged_in, only: [:create, :new]
  before_action :is_moderator, only: [:edit, :update]

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def index
    @subs = Sub.all

    render :index
  end

  def new
    @sub = Sub.new

    render :new
  end

  def edit
    @sub = Sub.find(params[:id])

    render :edit
  end

  def show
    @sub = Sub.find(params[:id])

    render :show
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end



  private
    def sub_params
      params.require(:sub).permit(:title, :moderator_id, :description)
    end

    def is_moderator
      @sub = Sub.find(params[:id])
      unless current_user == @sub.moderator
        redirect_to sub_url(@sub)
      end
    end

    def is_logged_in
      redirect_to subs_url unless logged_in?
    end

end
