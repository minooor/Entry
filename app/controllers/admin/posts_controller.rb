class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.order(game_on: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:game_on, :ground, :content, :category, :is_active)
  end
end
