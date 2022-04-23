class Public::NotificationsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @notifications = current_customer.passive_notifications.order(created_at: :desc)
  end

  def destroy
    notification = Notification.find(params[:id])
    notification.destroy
    redirect_back(fallback_location: root_path)
  end

  def update
    notification = Notification.find(params[:id])
    if notification.update(checked: true)
      redirect_to action: :index
    end
  end

end