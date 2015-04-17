class PostsController < ApplicationController
  before_action :is_author, only: [:edit, :update]

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
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
    # @old_subs = @post.subs
    # @new_subs = params[:post][:sub_ids].keys
    render :edit
  end

  def show
    @post = Post.find(params[:id])

    render :show
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to sub_url(@post.subs.first)
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :content, :author_id, sub_ids: [])
    end

    def is_author
      @post = Post.find(params[:id])
      unless current_user == @post.author
        redirect_to sub_url(@post.subs.first)
      end
    end

end
