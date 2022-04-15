class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @profile = Profile.find(params[:profile_id])
    @favorite = current_customer.favorites.new(profile_id: @profile.id)
    @favorite.save
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @favorite = current_customer.favorites.find_by(profile_id: @profile.id)
    @favorite.destroy
  end
end
