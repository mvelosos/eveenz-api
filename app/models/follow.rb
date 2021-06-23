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

  def account_follow_notification
    return unless Rails.env.production?

    FollowPushNotificationJob.perform_later(self)
  end

  def block!
    update_attribute(:blocked, true)
  end
end
