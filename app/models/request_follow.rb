# == Schema Information
#
# Table name: request_follows
#
#  id              :bigint           not null, primary key
#  requested_by_id :bigint           not null
#  account_id      :bigint           not null
#  accepted        :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class RequestFollow < ApplicationRecord
  belongs_to :requested_by, class_name: 'Account', foreign_key: 'requested_by_id'
  belongs_to :account

  validates :requested_by_id, uniqueness: { scope: :account_id }

  after_create :request_follow_notification
  after_save :on_update_accepted, if: :saved_change_to_accepted?

  private

  def on_update_accepted
    # if accepted?
    # else
    # end
  end

  def request_follow_notification
    Notification.create(account_id: account_id,
                        notifiable_type: 'RequestFollow',
                        notifiable_id: id,
                        notification_type: Notification::REQUEST_FOLLOW_TYPE)

    return unless Rails.env.production?

    RequestFollowPushNotificationJob.perform_later(self)
  end
end