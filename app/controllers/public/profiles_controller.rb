class Public::ProfilesController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :update]

  def show
    @profile_new = Profile.new
    @customer = @profile.customer
    @profile_comment = ProfileComment.new
  end

  def new
    flash.now[:notice] = "チームプロフィールを作成してください"
    return redirect_to profile_path(current_customer.profile) if current_customer.profile.present?
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.customer = current_customer
    if @profile.save
      flash[:notice] = "プロフィールを登録しました"
      redirect_to profile_path(@profile.id)
    else
      render :new
    end
  end

  def edit
    @profile.customer == current_customer
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "プロフィールを変更しました"
      redirect_to profile_path(@profile.id)
    else
      render :edit
    end
  end

  def index
    @q = Profile.ransack(params[:q])
    @profiles = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(8)
  end

  def find_profile
    @profile = Profile.find(params[:id])
  end

  private
  def profile_params
    params.require(:profile).permit(:name, :member, :address, :level, :activity_day, :profile_image, :category )
  end

end
