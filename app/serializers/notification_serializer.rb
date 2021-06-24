# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  notifiable_type   :string           not null
#  notifiable_id     :bigint           not null
#  notification_type :string
#  viewed            :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  discarded_at      :datetime
#  account_id        :bigint           not null
#
class NotificationSerializer < ActiveModel::Serializer
  attributes :notification_type,
             :follower,
             :created_at,
             :followed_by_me

  def follower
    return nil unless object.notification_type == Notification::FOLLOW_TYPE

    account = Account.find(object.notifiable_id)
    ActiveModelSerializers::SerializableResource.new(account,
                                                     serializer: AccountFollowNotificationSerializer,
                                                     adapter: :attributes)
  end

  def followed_by_me
    return nil unless object.notification_type == Notification::FOLLOW_TYPE

    account = Account.find(object.notifiable_id)
    account.followed_by?(scope.account)
  end
end
