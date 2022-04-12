class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @rooms = current_customer.customer_rooms.pluck(:room_id)
    @events = Event.all.where(customer_id: current_customer.id)
    @event = Event.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def index
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdraw
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:profile_id)
    @favorite_profiles = Profile.find(favorites)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image)
  end

end
