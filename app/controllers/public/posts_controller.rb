class Public::PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all.order(game_on: :desc)
  end

  def show
  end


  def new
    #募集画面にはprofileがなければいけないように設定
    return redirect_to new_profile_path if current_customer.profile.blank?
    @customer = current_customer
    @post = Post.new
    @posts = @customer.posts
  end

  def create
    @post = Post.new(post_params)
    @post.customer = current_customer
    if @post.save
      redirect_to post_path(@post)
    else
      @customer = current_customer
      @posts = @customer.posts
      render :new
    end
  end

  def edit
    @customer = current_customer
  end

  def update
    if @post.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to new_post_path
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def search_post
    @post = Post.new
    @posts = Post.search(params[:keyword])
  end

  private

  def post_params
    params.require(:post).permit(:game_on, :ground, :content, :category, :is_active)
  end

end
