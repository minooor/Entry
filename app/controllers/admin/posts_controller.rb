class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.order(game_on: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:game_on, :ground, :content, :category, :is_active)
  end
end
