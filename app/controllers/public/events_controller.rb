class Public::EventsController < ApplicationController
  before_action :authenticate_customer!
  before_action :find_event, only: [:show, :edit, :update, :destroy]
  before_action :set_beginning_of_week

  def index
  end

  def new
    @event = Event.new
  end

  def create
    @event= Event.new(event_params)
    @event.customer = current_customer
    if @event.save
      flash[:notice] = "予定を登録しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "入力してください"
      redirect_to customer_path(current_customer)
    end
  end

  def show
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "予定を変更しました"
      redirect_to event_path(@event)
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    @event.destroy
    flash[:notice] = "予定を削除しました"
    redirect_to customer_path(current_customer)
  end

  def find_event
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :start_time, :end_time)
  end

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

end
