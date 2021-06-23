class Api::V1::NotificationsController < Api::V1::ApiController
  # GET /notifications
  def index
    @notifications = Notification.where(account_id: current_user.account.id).order(created_at: :desc)
    api_list_render(@notifications, each_serializer: NotificationSerializer)
  end
end
