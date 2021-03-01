class FollowNotificationJob < ApplicationJob
  queue_as :push_notifications

  def perform(follow)
    title   = 'Novo seguidor'
    content = "@#{follow.follower.user.username} está seguindo você!"
    users   = [follow.followable.uuid]

    notification = Api::V1::Notifications::PushNotificationsService.new
    notification.push_to_users(title, content, users)
  end
end