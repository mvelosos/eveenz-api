# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  user_id      :bigint
#  name         :string
#  bio          :text
#  popularity   :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

class AccountSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :uuid,
             :username,
             :name,
             :bio,
             :popularity,
             :events,
             :following,
             :followers,
             :avatar_url,
             :followed_by_me,
             :private_account

  attribute :requested_by_me, if: :private_account?

  def username
    object.user.username
  end

  def events
    object.events.count
  end

  def following
    object.following_by_type('Account').count
  end

  def followers
    object.followers_count
  end

  def avatar_url
    rails_blob_url(object.avatar)
  end

  def followed_by_me
    object.followed_by?(@instance_options[:current_user].account)
  end

  def requested_by_me
    request_follow = RequestFollow.where(requested_by: @instance_options[:current_user].account, account: object).first

    {
      is_requested_by_me: request_follow.present?,
      request_follow_uuid: request_follow.present? ? request_follow.uuid : nil
    }
  end

  def private_account
    object.account_setting.private?
  end

  def private_account?
    object.account_setting.private?
  end
end
