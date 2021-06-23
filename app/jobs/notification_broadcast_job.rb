class NotificationBroadcastJob < ApplicationJob
  queue_as :notifications

  def perform(notification)
    ActionCable.server.broadcast('private', message: 'xundaaa', type: 'notification')
  end
end
