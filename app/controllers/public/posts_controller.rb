class Public::PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer = current_customer
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy(post_params)
      redirect_to posts_path
    else
      render :show
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:game_on, :prefecture, :ground, :content)
  end

end
