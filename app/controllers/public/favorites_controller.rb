class Public::FavoritesController < ApplicationController

  def create
    @profile = Profile.find(params[:profile_id])
    @favorite = current_customer.favorites.new(profile_id: @profile.id)
    @favorite.save
    redirect_to profile_path(@profile)
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @favorite = current_customer.favorites.find_by(profile_id: @profile.id)
    @favorite.destroy
    redirect_to profile_path(@profile)
  end
end
