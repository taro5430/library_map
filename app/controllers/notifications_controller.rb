class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.order('created_at DESC')
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy_all
    @notification = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
