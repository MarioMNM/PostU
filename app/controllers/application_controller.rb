class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_query
  before_action :set_notifications, if: :current_user

  def set_query
    @query = Micropost.ransack(params[:q])
  end

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

    def set_notifications
      notifications = Notification.where(recipient: current_user).newest_first.limit(9)
      @unread = notifications.unread
      @read = notifications.read
    end
end