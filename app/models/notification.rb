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
  NOTIFICATION_TYPES = [
    FOLLOW_TYPE
  ].freeze

  belongs_to :account
  belongs_to :notifiable, polymorphic: true

  validates :notification_type, presence: true, inclusion: { in: NOTIFICATION_TYPES }

  after_create { NotificationBroadcastJob.perform_later(self) }
end