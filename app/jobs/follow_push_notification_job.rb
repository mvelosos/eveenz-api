class FollowPushNotificationJob < ApplicationJob
  queue_as :push_notifications

  def perform(follow)
    title   = ''
    content = "#{follow.follower.name} (@#{follow.follower.user.username}) começou a seguir você!"
    users   = [follow.followable.uuid]

    notification = Api::V1::Notifications::PushNotificationsService.new
    notification.push_to_users(title, content, users)
  end
end
