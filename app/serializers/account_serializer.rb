# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  user_id      :bigint
#  username     :string
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
             :avatar_url

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
