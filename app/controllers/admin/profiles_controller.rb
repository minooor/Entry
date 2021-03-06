class Admin::ProfilesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = Profile.ransack(params[:q])
    @profiles = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @profile = Profile.find(params[:id])
  end


  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to admin_profile_path(@profile.id)
    else
      render edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :member, :address, :level, :activity_day, :profile_image, :category )
  end

end
