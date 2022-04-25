class Public::PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def new
    #募集画面にはprofileがなければいけないように設定
    return redirect_to new_profile_path if current_customer.profile.blank?
    @customer = current_customer
    @post = Post.new
    @posts = @customer.posts.order(created_at: :desc).page(params[:page])
  end

  def create
    @post = Post.new(post_params)
    @post.customer = current_customer
    if @post.save
      flash[:notice] = "募集を投稿しました"
      redirect_to post_path(@post)
    else
      @customer = current_customer
      @posts = @customer.posts.order(created_at: :desc).page(params[:page])
      render :new
    end
  end

  def edit
    @customer = current_customer
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "募集内容を変更しました"
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "募集を削除しました"
    redirect_to new_post_path
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def search_post
    @post = Post.new
    @posts = Post.search(params[:keyword]).page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:game_on, :ground, :content, :category, :is_active)
  end

end
