# == Schema Information

#
# Table name: follows
#
#  id              :bigint           not null, primary key
#  followable_type :string           not null
#  followable_id   :bigint           not null
#  follower_type   :string           not null
#  follower_id     :bigint           not null
#  blocked         :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Follow < ActiveRecord::Base
  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" and "follower" interface
  belongs_to :followable, polymorphic: true
  belongs_to :follower,   polymorphic: true

  after_create :account_follow_notification, if: -> { followable_type == 'Account' }
  after_destroy :destroy_account_follow_notification

  def account_follow_notification
    Notification.create(account_id: followable.id,
                        notifiable_type: 'Account',
                        notifiable_id: follower.id,
                        notification_type: Notification::FOLLOW_TYPE)

    return unless Rails.env.production?

    FollowPushNotificationJob.perform_later(self)
  end

  def destroy_account_follow_notification
    notifications = Notification.where(account_id: followable_id,
                                       notifiable_id: follower_id,
                                       notifiable_type: 'Account',
                                       notification_type: Notification::FOLLOW_TYPE)
    notifications.destroy_all if notifications.exists?
  end

  def block!
    update_attribute(:blocked, true)
  end
end
