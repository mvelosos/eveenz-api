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
  attributes :username, :name, :bio, :popularity, :following, :followers, :avatar_url

  def username
    object.user.username
  end

  def following
    object.following_by_type('Account').count
  end

  def followers
    object.followers_count
  end

  def avatar_url
    @instance_options[:avatar]
  end
end
