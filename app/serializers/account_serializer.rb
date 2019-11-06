# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  name       :string
#  bio        :text
#  popularity :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AccountSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :type, :uuid, :username, :name, :bio, :popularity, :events, :following, :followers, :avatar_url

  def type
    'account'
  end
  
  def uuid
    SecureRandom.uuid
  end

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
end
