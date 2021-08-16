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
class NotificationSerializer < ActiveModel::Serializer
  attributes :notification_type,
             :followed_by_me,
             :created_at

  attribute :follower,          if: :follow_type?
  attribute :request_follow_uuid, if: :request_follow_type?
  attribute :requested_by,      if: :request_follow_type?

  def follower
    account = Account.find(object.notifiable_id)
    ActiveModelSerializers::SerializableResource.new(account,
                                                     serializer: AccountFollowNotificationSerializer,
                                                     adapter: :attributes)
  end

  def request_follow_uuid
    request_follow = RequestFollow.find(object.notifiable_id)
    request_follow.uuid
  end

  def requested_by
    request_follow = RequestFollow.find(object.notifiable_id)
    account = request_follow.requested_by
    ActiveModelSerializers::SerializableResource.new(account,
                                                     serializer: AccountFollowNotificationSerializer,
                                                     adapter: :attributes)
  end

  def followed_by_me
    if follow_type?
      account = Account.find(object.notifiable_id)
      return account.followed_by?(scope.account)
    end

    if request_follow_type?
      request_follow = RequestFollow.find(object.notifiable_id)
      account = request_follow.requested_by
      return account.followed_by?(scope.account)
    end

    nil
  end

  def follow_type?
    object.follow_type?
  end

  def request_follow_type?
    object.request_follow_type?
  end
end
