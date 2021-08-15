class RequestFollowNotificationJob < ApplicationJob
  queue_as :push_notifications

  def perform(request_follow)
    title   = ''
    content = "#{request_follow.requested_by.name} (@#{request_follow.requested_by.user.username}) solicitou seguir você"
    users   = [request_follow.account.uuid]

    notification_service = Api::V1::Notifications::PushNotificationsService.new
    notification_service.push_to_users(title, content, users)
  end
end
