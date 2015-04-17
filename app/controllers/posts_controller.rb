class PostsController < ApplicationController
  before_action :is_author, only: [:edit, :update]

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    #["1", "3", "4"] Sub.find(4)
    params[:post][:sub_ids].keys.each do |sub_id|
      @post.subs << Sub.find(sub_id.to_i)
      @post.post_subs.new(sub_id: sub_id)
    end

    if @post.save!
      redirect_to sub_url(@post.subs.first)
    else
      render :new
    end
  end

  def new
    @post = Post.new

    render :new
  end

  def edit
    @post = Post.find(params[:id])

    render :edit
  end

  def show
    @post = Post.find(params[:id])

    render :show
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to sub_url(@post.sub)
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :content, :author_id, :sub_ids)
    end

    def is_author
      @post = Post.find(params[:id])
      unless current_user == @post.author
        redirect_to sub_url(@post.sub)
      end
    end

end
