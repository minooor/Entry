class Admin::ProfilesController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_profile, only: [:show, :update]
  
  def index
    @profiles = Profile.all
  end
  
  def find_profile
    @profile = Profile.find(params[:id])
  end
  
  def show
  end
  
  
  def update
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
