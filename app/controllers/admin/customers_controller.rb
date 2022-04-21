class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_customer, only: [:show, :edit, :update]

  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result(distinct: true).page(params[:page]).per(8)
  end

  def show
    @profile = Profile.find_by(params[:id])
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customers_path(@customer.id)
    else
      @customers = Customer.page(params[:page])
      render :edit
    end
  end

  def find_customer
    @customer = Customer.find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image, :is_deleted)
  end

end
