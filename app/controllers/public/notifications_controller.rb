class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_customer.passive_notifications
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