# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  account_id        :bigint
#  notifiable_type   :string           not null
#  notifiable_id     :bigint           not null
#  notification_type :string
#  viewed            :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  discarded_at      :datetime
#
class Notification < ApplicationRecord
  include Discard::Model

  FOLLOW_TYPE = 'follow'.freeze
  REQUEST_FOLLOW_TYPE = 'request_follow'.freeze
  NOTIFICATION_TYPES = [
    FOLLOW_TYPE,
    REQUEST_FOLLOW_TYPE
  ].freeze

  belongs_to :account
  belongs_to :notifiable, polymorphic: true

  validates :notification_type, presence: true, inclusion: { in: NOTIFICATION_TYPES }

  after_create :broadcast_notification

  def follow_type?
    notification_type == FOLLOW_TYPE
  end

  def request_follow_type?
    notification_type == REQUEST_FOLLOW_TYPE
  end

  private

  def broadcast_notification
    return unless Rails.env.production? || Rails.env.staging?

    NotificationBroadcastJob.perform_later(self)
  end
end
