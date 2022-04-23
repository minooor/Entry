class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @customers = Customer.where(is_deleted: false)
    @customer= @customers.page(params[:page]).per(5).order(created_at: :desc)
    @posts = Post.all
    @post = @posts.page(params[:page]).per(5).order(created_at: :desc)
    @profiles = Profile.all
  end

end
