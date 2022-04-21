class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :find_customer, only: [:show, :edit, :unsubscribe, :withdraw ]

  def show
    @rooms = current_customer.customer_rooms.pluck(:room_id)
    @events = Event.all.where(customer_id: current_customer.id)
    @event = Event.new
  end

  def edit
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を変更しました"
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def index
  end

  def unsubscribe
  end

  def withdraw
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

  def find_customer
    @customer = current_customer
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image, :is_deleted)
  end

end
